//
//  OpenCameraService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 25/10/22.
//

import Foundation
import UIKit
import AVFoundation

public class OpenCameraService: NSObject, IOpenCameraService, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    public var imagePickerController: UIImagePickerController = UIImagePickerController()
    public let allowsEditing: Bool
    public var delegate: IOpenCameraServiceDelegate?
    
    public init(allowsEditing: Bool = false) {
        self.allowsEditing = allowsEditing
        super.init()
        self.configureImagePickerController()
    }
    
    public func configureImagePickerController() -> Void {
        self.imagePickerController.allowsEditing = self.allowsEditing
        self.imagePickerController.delegate = self
        let sourceType = UIImagePickerController.SourceType.camera
        let isSourceTypeAvailable = UIImagePickerController.isSourceTypeAvailable(sourceType)
        if isSourceTypeAvailable {
            self.imagePickerController.sourceType = .camera
        }
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
