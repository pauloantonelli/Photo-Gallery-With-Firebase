//
//  MediaPermission.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 25/10/22.
//

import Foundation
import AVFoundation

struct MediaPermissionService: IMediaPermissionService {
    internal let authorizationStatus: AVAuthorizationStatus
    
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
