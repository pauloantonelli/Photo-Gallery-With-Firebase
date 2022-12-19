//
//  HomeViewModel.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 19/12/22.
//

import SwiftUI
import Photo_Gallery_With_Firebase_SDK

enum MediaSource {
    case camera
    case gallery
}
protocol IHomeViewModel {
    
}
extension HomeView {
    class HomeViewModel: IHomeViewModel, IOpenCameraServiceDelegate, IOpenGalleryServiceDelegate, ObservableObject {
        let showAlertConstant: NSNotification.Name = NSNotification.Name("HomenAlert")
        var firebaseService: IFirebaseService
        var openCameraService: IOpenCameraService
        var openGalleryService: IOpenGalleryService
        var saveMediaUseCase: ISaveMediaUseCase
        var mediaSource: MediaSource = .camera
        var alert: Alert = Alert(
            title: Text(""),
            message: Text(""),
            dismissButton: .default(Text(""))
        )
        @Published var isLoading: Bool = false
        
        init(firebaseService: IFirebaseService,
             openCameraService: IOpenCameraService,
             openGalleryService: IOpenGalleryService,
             saveMediaUseCase: ISaveMediaUseCase) {
            self.firebaseService = firebaseService
            self.openCameraService = openCameraService
            self.openGalleryService = openGalleryService
            self.saveMediaUseCase = saveMediaUseCase
            self.setup()
        }
        
        func setup() -> Void {
            self.openCameraService.delegate = self
            self.openGalleryService.delegate = self
        }
        
        func updateImage(withImage image: UIImage) -> Void {
            Task {
                await self.saveImage(image: image)
            }
        }
        
        func openCamera() -> Void {
            self.mediaSource = .camera
            let camera = self.openCameraService.execute()
//            self.present(camera, animated: true)
        }
        
        func openGallery() -> Void {
            self.mediaSource = .gallery
            let gallery = self.openGalleryService.execute()
//            self.present(gallery, animated: true)
        }
        
        func alertAction() -> Void {
            
        }
        
        func showLoading() -> Void {
            self.isLoading = true
        }
        
        func hideLoading() -> Void {
            self.isLoading = false
        }
        
        func saveImage(image: UIImage) async -> Void {
            self.showLoading()
            do {
                let uid = UUID()
                let user: User = self.firebaseService.user
                let result = try await self.saveMediaUseCase.execute(fileName: "user-id-\(user.id)-photo-id-\(uid.uuidString)", image: image).get()
                self.showAlert(message: "Photo Saved")
                self.hideLoading()
                print("Save: \(result)")
            } catch let error as SaveMediaErrorUseCase {
                self.showAlert(message: "Photo not Saved! Try Again")
                self.hideLoading()
                print("SaveMediaErrorUseCase: \(error)")
            } catch {
                self.showAlert(message: "Photo not Saved! Try Again")
                self.hideLoading()
                print("Error: \(error)")
            }
        }
        
        func showAlert(title: String = "Image Save", message: String, actionTitle: String = "Done") -> Void {
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
