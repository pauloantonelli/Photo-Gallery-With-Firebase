//
//  CameraMediaService.swift
//  Photo Gallery App UiKit
//
//  Created by Paulo Antonelli on 04/11/22.
//

import Foundation
import UIKit
import AVFoundation

class CameraGetMediaService: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var imagePickerController: UIImagePickerController = UIImagePickerController()
    fileprivate let allowsEditing: Bool
    var delegate: CameraGetMediaServiceDelegate?
    
    init(allowsEditing: Bool = false, isCameraPhoto: Bool = true) {
        self.allowsEditing = allowsEditing
        super.init()
        self.configureImagePickerController(isCameraPhoto: isCameraPhoto)
    }
    
    func configureImagePickerController(isCameraPhoto: Bool) -> Void {
        imagePickerController.allowsEditing = self.allowsEditing
        imagePickerController.delegate = self
        if isCameraPhoto == true {
            imagePickerController.sourceType = .camera
        }
    }
    
    func execute() -> UIImagePickerController {
        return self.imagePickerController
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        var newImage: UIImage!
        if let image = info[.editedImage] as? UIImage {
            newImage = image
            print("photo editedImage")
        }
        if let image = info[.originalImage] as? UIImage {
            newImage = image
            print("photo originalImage")
        }
        print("photo ok")
        self.delegate?.updateImage(withImage: newImage)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancel photo")
        picker.dismiss(animated: true)
    }
}
