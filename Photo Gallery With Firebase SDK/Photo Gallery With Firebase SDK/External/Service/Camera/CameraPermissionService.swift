//
//  CameraPermissionService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 01/11/22.
//

import Foundation
import AVFoundation

public struct CameraPermissionService: ICameraPermissionService {
    let mediaPermissionService: IMediaPermissionService
    
    public init(mediaPermissionService: IMediaPermissionService = MediaPermissionService()) {
        self.mediaPermissionService = mediaPermissionService
    }
    
    public func execute() async throws -> Result<Bool, CameraPermissionErrorService> {
        let result = await self.mediaPermissionService.execute()
        if result == nil {
            throw CameraPermissionErrorService(message: "Error on Camera Permission Request: Permission Denied")
        }
        return .success(result!)
    }
}
