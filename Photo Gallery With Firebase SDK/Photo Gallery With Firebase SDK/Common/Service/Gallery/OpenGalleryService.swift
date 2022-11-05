//
//  OpenGalleryService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 25/10/22.
//

import Foundation
import UIKit
import AVFoundation

class OpenGalleryService: NSObject, IOpenGalleryService, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    internal var imagePickerController: UIImagePickerController = UIImagePickerController()
    internal var allowsEditing: Bool
    var delegate: IOpenGalleryServiceDelegate?
    
    init(allowsEditing: Bool = false) {
        self.allowsEditing = allowsEditing
        super.init()
        self.configureImagePickerController()
    }
    
    internal func configureImagePickerController() {
        imagePickerController.allowsEditing = self.allowsEditing
        imagePickerController.delegate = self
    }
    
    func execute() -> UIImagePickerController {
        return self.imagePickerController
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        if let image = info[.editedImage] as? UIImage {
            self.delegate?.updateImage(withImage: image)
        }
        if let image = info[.originalImage] as? UIImage {
            self.delegate?.updateImage(withImage: image)
        }
    }
    
    internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
