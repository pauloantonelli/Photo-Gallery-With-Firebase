//
//  GalleryPermissionService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 01/11/22.
//

import Foundation
import PhotosUI

public struct GalleryPermissionService: IGalleryPermissionService {
    var mediaPermissionService: MediaPermissionService
    
    public init(mediaPermissionService: MediaPermissionService = MediaPermissionService()) {
        self.mediaPermissionService = mediaPermissionService
    }
    
    public func execute() async throws -> Result<Bool, GalleryPermissionErrorService> {
        let result = await self.mediaPermissionService.execute()
        if result == nil {
            throw GalleryPermissionErrorService(message: "Error on Gallery Permission Request: Permission Denied")
        }
        return .success(result!)
    }
}
