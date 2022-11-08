//
//  CameraGetMediaService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 02/11/22.
//

import Foundation
import UIKit
import AVFoundation

struct CameraGetMediaService: ICameraGetMediaService, IOpenCameraServiceDelegate {
    var image: UIImage?
    var delegate: IOpenCameraServiceDelegate?
    let openCameraService: OpenCameraService
    
    init(openCameraService: OpenCameraService = OpenCameraService()) {
        self.openCameraService = openCameraService
        self.delegate = self
    }
    
    func execute() throws -> UIImage {
        do {
            guard let image = self.image else {
                throw CameraGetMediaErrorService(message: "Error on CameraGetMediaService: image not found")
            }
            return image
        } catch {
            throw CameraGetMediaErrorService(message: "Error on CameraGetMediaService \(error.localizedDescription)")
        }
    }
    
    func openCamera() {
        let result = self.openCameraService.execute()
    }
}
extension CameraGetMediaService {
    func openCamera() -> UIImagePickerController {
        <#code#>
    }
    
    mutating func updateImage(withImage image: UIImage) {
        self.image = image
        self.execute()
    }
}
