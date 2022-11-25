//
//  PermissionViewController.swift
//  Photo Gallery App UiKit
//
//  Created by Paulo Antonelli on 15/11/22.
//

import UIKit
import Photo_Gallery_With_Firebase_SDK

class PermissionViewController: UIViewController {
    var mediaPermissionService: IMediaPermissionService!
    var cameraPermissionUseCase: ICameraPermissionUseCase!
    var galleryPermissionUseCase: IGalleryPermissionUseCase!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mediaPermissionService = DependencyInjection.get(IMediaPermissionService.self)
        self.cameraPermissionUseCase = DependencyInjection.get(ICameraPermissionUseCase.self)
        self.galleryPermissionUseCase = DependencyInjection.get(IGalleryPermissionUseCase.self)
        self.initalization()
    }
    
    func initalization() {
        Task {
            let result = self.mediaPermissionService.authorizationStatus
            if result == .authorized {
                self.goToHomePage()
            }
        }
    }
    
    @IBAction func grantPermission(_ sender: UIButton) {
        Task {
            await self.doPermission()
        }
    }
    
    @IBAction func deniPermission(_ sender: Any) {
        self.doDenyPermission()
    }
}
extension PermissionViewController {
    func doPermission() async -> Void {
        let permission = await self.checkPermission()
        if permission == false {
            self.showAlert(message: "You need grant permission to capture photo and video, go to Settings > Photo Gallery App Uikit") { alertAction in
                if alertAction.isEnabled {
                    self.goToHomePage()
                }
            }
        }
        self.goToHomePage()
    }
    
    func doDenyPermission() -> Void {
        self.showAlert(message: "You need grant permission to capture photo and video, go to Settings > Photo Gallery App Uikit") { alertAction in
            if alertAction.isEnabled {
                self.goToHomePage()
            }
        }
    }
}
extension PermissionViewController {
    func cameraPermission() async -> Bool {
        do {
            let result = try await self.cameraPermissionUseCase.execute().get()
            return result
        } catch let error as CameraPermissionErrorUseCase {
            print(error.message)
            return false
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func galleryPermission() async -> Bool {
        do {
            let result = try await self.galleryPermissionUseCase.execute().get()
            return result
        } catch let error as GalleryPermissionErrorUseCase {
            print(error.message)
            return false
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func checkPermission() async -> Bool {
        let cameraPermission = await self.cameraPermission()
        let galleryPermission = await self.galleryPermission()
        let result = cameraPermission && galleryPermission
        return result
    }
    
    func goToHomePage() -> Void {
        self.performSegue(withIdentifier: Constant.goFromPermissionToHome, sender: self)
    }
}
extension PermissionViewController {
    func showAlert(title: String = "Unable to grant permition", message: String, actionTitle: String = "I understood", completion: ((UIAlertAction) -> Void)?) -> Void {
        let alert = AlertService.alert(title: title, message: message, actionTitle: actionTitle, completion: completion)
        self.present(alert, animated: true)
    }
}
