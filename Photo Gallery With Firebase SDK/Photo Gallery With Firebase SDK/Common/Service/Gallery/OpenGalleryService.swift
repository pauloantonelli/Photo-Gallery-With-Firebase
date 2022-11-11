//
//  OpenGalleryService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 25/10/22.
//

import Foundation
import UIKit
import AVFoundation

public class OpenGalleryService: NSObject, IOpenGalleryService, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    public var imagePickerController: UIImagePickerController = UIImagePickerController()
    public let allowsEditing: Bool
    public var delegate: IOpenGalleryServiceDelegate?
    
    public init(allowsEditing: Bool = false) {
        self.allowsEditing = allowsEditing
        super.init()
        self.configureImagePickerController()
    }
    
    public func configureImagePickerController() {
        self.imagePickerController.allowsEditing = self.allowsEditing
        self.imagePickerController.delegate = self
    }
    
    public func execute() -> UIImagePickerController {
        return self.imagePickerController
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        if let image = info[.editedImage] as? UIImage {
            self.delegate?.updateImage(withImage: image)
        }
        if let image = info[.originalImage] as? UIImage {
            self.delegate?.updateImage(withImage: image)
        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
