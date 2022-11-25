//
//  MediaPermissionService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 25/10/22.
//

import Foundation
import AVFoundation

public struct MediaPermissionService: IMediaPermissionService  {
    public var authorizationStatus: AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
    public var delegate: IMediaPermissionServiceDelegate?
    
    public init() {
    }
    
    public func execute() async -> Bool? {
        let status: AVAuthorizationStatus = self.authorizationStatus
        if status == .denied {
            self.delegate?.updatePermitionStatus(status: false)
            return nil
        }
        if status == .restricted {
            self.delegate?.updatePermitionStatus(status: false)
            return false
        }
        if status == .notDetermined {
            let permission = await self.askPermission()
            return permission
        }
        if status == .authorized {
            self.delegate?.updatePermitionStatus(status: true)
            return true
        }
        self.delegate?.updatePermitionStatus(status: false)
        return nil
    }
    
    public func askPermission() async -> Bool {
        let result = await AVCaptureDevice.requestAccess(for: .video)
        return result
    }
}
