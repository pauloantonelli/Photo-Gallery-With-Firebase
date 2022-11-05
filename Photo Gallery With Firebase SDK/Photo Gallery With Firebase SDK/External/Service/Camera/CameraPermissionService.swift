//
//  CameraPermissionService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 01/11/22.
//

import Foundation
import AVFoundation

struct CameraPermissionService: ICameraPermissionService {
    var authorizationStatus: AVAuthorizationStatus
    
    init(authorizationStatus: AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)) {
        self.authorizationStatus = authorizationStatus
    }
    
    func execute() -> Result<Bool, CameraPermissionErrorService> {
        let result = self.authorizationStatus
        if result == .denied {
            return .success(false)
        }
        if result == .restricted {
            return .success(false)
        }
        if result == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video) { _ in
                self.execute()
            }
        }  
        if result == .authorized {
            return .success(true)
        }
        return .failure(CameraPermissionErrorService(message: "Error on Camera Permission Request"))
    }
}
