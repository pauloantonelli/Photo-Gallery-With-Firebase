//
//  ICameraGetMediaDrive.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 02/11/22.
//

import Foundation
import UIKit

protocol ICameraGetMediaDrive {
    func execute() async -> Result<UIImage, CameraGetMediaErrorUseCase>
}
