//
//  ViewController.swift
//  Photo Gallery App UiKit
//
//  Created by Paulo Antonelli on 04/11/22.
//

import UIKit
import Photo_Gallery_With_Firebase_SDK

class ViewController: UIViewController, ICheckNetworkServiceDelegate, IOpenGalleryServiceDelegate, IOpenCameraServiceDelegate {
    var checkNetwork: ICheckNetworkService = CheckNetworkService()
    var mediaPermissionService: IMediaPermissionService = MediaPermissionService()
    var galleryMediaService: IOpenGalleryService = OpenGalleryService(allowsEditing: false)
    var cameraMediaService: IOpenCameraService = OpenCameraService(allowsEditing: false)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkNetwork.delegate = self
        self.galleryMediaService.delegate = self
        self.cameraMediaService.delegate = self
    }
    
    @IBAction func permissionButton(_ sender: UIButton) {
        self.permission()
    }
    
    @IBAction func cameraButton(_ sender: UIButton) {
        self.camera()
    }
    
    @IBAction func galleryButton(_ sender: UIButton) {
        self.gallery()
    }
    
    func permission() -> Void {
        let result = self.mediaPermissionService.execute()
        present(self.alertFactory(title: "Camera and Gallery permission", message: "status \(String(describing: result))", actionTitle: "fechar"), animated: true)
    }
    
    func camera() -> Void {
        let result = self.cameraMediaService.execute()
        present(result, animated: true)
    }
    
    func gallery() -> Void {
        let result = self.galleryMediaService.execute()
        present(result, animated: true)
    }
    
    func updateImage(withImage image: UIImage) -> Void {
        present(self.alertFactory(title: "New Image", message: "image size \(image.size)", actionTitle: "fechar"), animated: true)
    }
    
    func updateNetworkStatus(status: Bool) {
        present(self.alertFactory(title: "Network", message: "has connection \(status)", actionTitle: "fechar"), animated: true)
    }
    
    func alertFactory(title: String, message: String, actionTitle: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default))
        return alert
    }
}

