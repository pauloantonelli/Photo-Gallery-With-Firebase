//
//  CameraPhoto.swift
//  Photo Gallery App UiKit
//
//  Created by Paulo Antonelli on 04/11/22.
//

import Foundation
import AVFoundation

struct CameraPermissionService {
    var authorizationStatus: AVAuthorizationStatus
    
    init(authorizationStatus: AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)) {
        self.authorizationStatus = authorizationStatus
    }
    
    func execute() -> Bool {
        let result = self.authorizationStatus
        if result == .denied {
            return false
        }
        if result == .restricted {
            return false
        }
        if result == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video) { _ in
                self.execute()
            }
        }
        if result == .authorized {
            return true
        }
        return false
    }
}
