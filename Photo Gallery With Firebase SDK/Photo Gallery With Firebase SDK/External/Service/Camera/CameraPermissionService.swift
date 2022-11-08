//
//  CameraPermissionService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 01/11/22.
//

import Foundation
import AVFoundation

struct CameraPermissionService: ICameraPermissionService {
    var mediaPermissionService: MediaPermissionService
    
    init(mediaPermissionService: MediaPermissionService = MediaPermissionService()) {
        self.mediaPermissionService = mediaPermissionService
    }
    
    func execute() throws -> Result<Bool, CameraPermissionErrorService> {
        let result = self.mediaPermissionService.execute()
        if result == nil {
            throw CameraPermissionErrorService(message: "Error on Camera Permission Request: Permission Denied")
        }
        return .success(result!)
    }
}
