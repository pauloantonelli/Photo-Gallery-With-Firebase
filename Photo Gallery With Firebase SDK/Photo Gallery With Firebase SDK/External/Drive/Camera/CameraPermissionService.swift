//
//  CameraPermissionService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 01/11/22.
//

import Foundation
import AVFoundation

struct CameraPermissionService: ICameraPermissionService {    
    func execute() async -> Result<Bool, CameraPermissionErrorService> {
        let result = AVCaptureDevice.authorizationStatus(for: .video)
        if result == .denied {
            return .success(false)
        }
        if result == .restricted {
            return .success(false)
        }
        if result == .notDetermined {
            let permission = await AVCaptureDevice.requestAccess(for: .video)
            return .success(permission)
        }
        if result == .authorized {
            return .success(true)
        }
        return .failure(CameraPermissionErrorService(message: "Error on Camera Permission Request"))
    }
}
