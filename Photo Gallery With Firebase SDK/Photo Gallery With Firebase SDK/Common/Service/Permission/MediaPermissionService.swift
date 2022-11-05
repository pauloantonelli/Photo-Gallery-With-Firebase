//
//  MediaPermissionService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 25/10/22.
//

import Foundation
import AVFoundation

struct MediaPermissionService: IMediaPermissionService  {
    internal let authorizationStatus: AVAuthorizationStatus
    var delegate: IMediaPermissionServiceDelegate?
    
    init(authorizationStatus: AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)) {
        self.authorizationStatus = authorizationStatus
    }
    
    func execute() -> Bool {
        let result = self.authorizationStatus
        if result == .denied {
            self.delegate?.updatePermitionStatus(status: false)
            return false
        }
        if result == .restricted {
            self.delegate?.updatePermitionStatus(status: false)
            return false
        }
        if result == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video) { _ in
                self.execute()
            }
        }
        if result == .authorized {
            self.delegate?.updatePermitionStatus(status: true)
            return true
        }
        self.delegate?.updatePermitionStatus(status: false)
        return false
    }
}
