//
//  IOpenCameraService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 05/11/22.
//

import Foundation
import UIKit
import AVFoundation

public protocol IOpenCameraService {
    var imagePickerController: UIImagePickerController { get }
    var allowsEditing: Bool { get }
    var delegate: IOpenCameraServiceDelegate? { get set }
    
    func configureImagePickerController() -> Void
    func execute() -> UIImagePickerController
}
