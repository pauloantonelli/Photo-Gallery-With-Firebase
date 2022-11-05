//
//  IOpenGalleryService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 05/11/22.
//

import Foundation
import UIKit
import AVFoundation

protocol IOpenGalleryService {
    var imagePickerController: UIImagePickerController { get }
    var allowsEditing: Bool { get }
    var delegate: IOpenGalleryServiceDelegate? { get set }
    
    func configureImagePickerController() -> Void
    func execute() -> UIImagePickerController
}
