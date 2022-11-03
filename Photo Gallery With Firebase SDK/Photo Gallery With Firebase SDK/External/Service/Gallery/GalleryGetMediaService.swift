//
//  CameraGetMediaService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 02/11/22.
//

import Foundation
import UIKit

class GalleryGetMediaService: NSObject, IGalleryGetMediaService {
    let imagePickerController: UIImagePickerController = UIImagePickerController()
    var image: UIImage?
    
    override init() {
        super.init()
        self.configHandler()
    }
    
    func execute() async throws -> UIImage {
        guard let image = self.image else {
            throw GalleryGetMediaErrorService(message: "Error on GalleryGetMediaService: image not found")
        }
        return image
    }
}

extension GalleryGetMediaService: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func configHandler() -> Void {
        self.imagePickerController.sourceType = .photoLibrary
        self.imagePickerController.delegate = self
        self.imagePickerController.allowsEditing = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.image = image
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
 
