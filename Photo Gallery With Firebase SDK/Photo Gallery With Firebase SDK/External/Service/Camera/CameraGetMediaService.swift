//
//  CameraGetMediaService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 02/11/22.
//

import Foundation
import UIKit
import AVFoundation

class CameraGetMediaService: NSObject, ICameraGetMediaService {
    let captureSession: AVCaptureSession
    let capturePhotoOutput: AVCapturePhotoOutput = AVCapturePhotoOutput()
    var image: UIImage?
    
    init(captureSession: AVCaptureSession = AVCaptureSession()) {
        self.captureSession = captureSession
        super.init()
        self.configHandler()
    }
    
    func execute() async throws -> UIImage {
        let isAvaliableCamera = await UIImagePickerController.isSourceTypeAvailable(.camera)
        do {
            if isAvaliableCamera == false {
                throw CameraGetMediaErrorService(message: "Error on CameraGetMediaService: isAvaliableCamera \(isAvaliableCamera)")
            }
            self.captureSession.startRunning()
            self.photoHandler()
            guard let image = self.image else {
                throw CameraGetMediaErrorService(message: "Error on CameraGetMediaService: image not found")
            }
            return image
        } catch {
            throw CameraGetMediaErrorService(message: "Error on CameraGetMediaService \(error.localizedDescription)")
        }
    }
}

extension CameraGetMediaService: AVCapturePhotoCaptureDelegate {
    func configHandler() -> Void {
        if let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) {
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)
                if self.captureSession.canAddInput(input) {
                    self.captureSession.addInput(input)
                }
            } catch {
                print("Error to set input device: \(error.localizedDescription)")
            }
            if self.captureSession.canAddOutput(self.capturePhotoOutput) {
                self.captureSession.addOutput(self.capturePhotoOutput)
            }
        } else {
            print("Error to find capture device")
        }
    }
    
    func photoHandler() -> Void {
        let photoSettings = AVCapturePhotoSettings()
        if let photoPreviewType = photoSettings.availablePreviewPhotoPixelFormatTypes.first {
            photoSettings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String : photoPreviewType]
            self.capturePhotoOutput.capturePhoto(with: photoSettings, delegate: self)
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else { return }
        let imagePreview = UIImage(data: imageData)
        self.image = imagePreview
    }
}
