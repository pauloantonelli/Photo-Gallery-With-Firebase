//
//  ViewController.swift
//  Photo Gallery App UiKit
//
//  Created by Paulo Antonelli on 04/11/22.
//

import UIKit
import Photo_Gallery_With_Firebase_SDK

class ViewController: UIViewController, CheckNetworkDelegate, ICameraMediaServiceDelegate, IGalleryMediaServiceDelegate {
    var cameraPermissionService: MediaPermissionService = MediaPermissionService()
    var cameraMediaService: ICameraMediaService = CameraMediaService(allowsEditing: true)
    var galleryMediaService: IGalleryMediaService = GalleryMediaService(allowsEditing: true)
    var checkNetwork: CheckNetwork = CheckNetwork()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkNetwork.delegate = self
        self.cameraMediaService.delegate = self
        self.galleryMediaService.delegate = self
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
        let result = self.cameraPermissionService.execute()
        present(self.alertFactory(title: "Camera and Gallery permission", message: "status \(result)", actionTitle: "fechar"), animated: true)
    }
    
    func camera() -> Void {
        let result = self.cameraMediaService.execute()
        present(result, animated: true)
    }
    
    func gallery() -> Void {
        let result = self.galleryMediaService.execute()
        present(result, animated: true)
    }
    
    func updateImage(withImage image: UIImage) {
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

