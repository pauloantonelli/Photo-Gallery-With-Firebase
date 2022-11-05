//
//  ICameraMediaService.swift
//  Photo Gallery App UiKit
//
//  Created by Paulo Antonelli on 05/11/22.
//

import Foundation
import UIKit
import AVFoundation

protocol ICameraMediaService {
    var imagePickerController: UIImagePickerController { get }
    var allowsEditing: Bool { get }
    var delegate: ICameraMediaServiceDelegate? { get set }
    
    func configureImagePickerController() -> Void
    func execute() -> UIImagePickerController
}
