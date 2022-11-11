//
//  MediaPermissionService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 25/10/22.
//

import Foundation
import AVFoundation

public struct MediaPermissionService: IMediaPermissionService  {
    public let authorizationStatus: AVAuthorizationStatus
    public var delegate: IMediaPermissionServiceDelegate?
    
    public init(authorizationStatus: AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)) {
        self.authorizationStatus = authorizationStatus
    }
    
    public func execute() -> Bool? {
        let result = self.authorizationStatus
        if result == .denied {
            self.delegate?.updatePermitionStatus(status: false)
            return nil
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
        return nil
    }
}
