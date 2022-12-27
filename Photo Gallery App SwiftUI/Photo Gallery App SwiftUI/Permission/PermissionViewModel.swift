//
//  PermissionViewModel.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 19/12/22.
//

import SwiftUI
import Photo_Gallery_With_Firebase_SDK

protocol IPermissionViewModel {
    func initalization() -> Void
    func grantPermission() -> Void
    func deniPermission() -> Void
    func doPermission() async -> Void
    func doDenyPermission() -> Void
    func checkPermission() async -> Bool
    func cameraPermission() async -> Bool
    func galleryPermission() async -> Bool
    func goToHomePage() -> Void
    func showAlert(title: String, message: String, actionTitle: String) -> Void
    func emitAlertStatus(status: Bool) -> Void 
}

extension PermissionView {
    class PermissionViewModel: IPermissionViewModel, ObservableObject {
        let showAlertConstant: NSNotification.Name = NSNotification.Name("PermissionAlert")
        var mediaPermissionService: IMediaPermissionService!
        var cameraPermissionUseCase: ICameraPermissionUseCase!
        var galleryPermissionUseCase: IGalleryPermissionUseCase!
        @Published var canGoToHomePage: Bool = false
        var alert: Alert = Alert(
            title: Text(""),
            message: Text(""),
            dismissButton: .default(Text(""))
        )
        
        init(mediaPermissionService: IMediaPermissionService!, cameraPermissionUseCase: ICameraPermissionUseCase!, galleryPermissionUseCase: IGalleryPermissionUseCase!) {
            self.mediaPermissionService = mediaPermissionService
            self.cameraPermissionUseCase = cameraPermissionUseCase
            self.galleryPermissionUseCase = galleryPermissionUseCase
            self.initalization()
        }
        
        func initalization() -> Void {
            Task {
                let result = self.mediaPermissionService.authorizationStatus
                if result == .authorized {
                    self.goToHomePage()
                }
            }
        }
        
        func grantPermission() -> Void {
            Task {
                await self.doPermission()
            }
        }
        
        func deniPermission() -> Void {
            self.doDenyPermission()
        }
        
        func doPermission() async -> Void {
            let permission = await self.checkPermission()
            if permission == false {
                self.showAlert(message: "You need grant permission to capture photo and video, go to Settings > Photo Gallery App SwiftUI")
            }
            self.goToHomePage()
        }
        
        func doDenyPermission() -> Void {
            self.showAlert(message: "You need grant permission to capture photo and video, go to Settings > Photo Gallery App SwiftUI")
        }
        
        func checkPermission() async -> Bool {
            let cameraPermission = await self.cameraPermission()
            let galleryPermission = await self.galleryPermission()
            let result = cameraPermission && galleryPermission
            return result
        }
        
        func cameraPermission() async -> Bool {
            do {
                let result = try await self.cameraPermissionUseCase.execute().get()
                return result
            } catch let error as CameraPermissionErrorUseCase {
                print(error.message)
                self.showAlert(message: error.message)
                return false
            } catch {
                print(error.localizedDescription)
                self.showAlert(message: error.localizedDescription)
                return false
            }
        }
        
        func galleryPermission() async -> Bool {
            do {
                let result = try await self.galleryPermissionUseCase.execute().get()
                return result
            } catch let error as GalleryPermissionErrorUseCase {
                print(error.message)
                self.showAlert(message: error.message)
                return false
            } catch {
                print(error.localizedDescription)
                self.showAlert(message: error.localizedDescription)
                return false
            }
        }
        
        func goToHomePage() -> Void {
            DispatchQueue.main.async {
                self.canGoToHomePage = true
                Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
                    self.canGoToHomePage = false
                }
            }
        }
        
        func alertAction() -> Void {
            self.goToHomePage()
        }
        
        func showAlert(title: String = "Unable to grant permition", message: String, actionTitle: String = "I understood") -> Void {
            let alert: Alert = Alert(
                title: Text(title),
                message: Text(message),
                dismissButton: .default(
                    Text(actionTitle),
                    action: self.alertAction
                )
            )
            self.alert = alert
            self.emitAlertStatus(status: true)
        }
        
        func emitAlertStatus(status: Bool) -> Void {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: self.showAlertConstant, object: status)
            }
        }
    }
}
