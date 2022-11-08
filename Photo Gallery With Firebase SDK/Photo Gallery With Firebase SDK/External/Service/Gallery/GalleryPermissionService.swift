//
//  GalleryPermissionService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 01/11/22.
//

import Foundation
import PhotosUI

struct GalleryPermissionService: IGalleryPermissionService {
    var mediaPermissionService: MediaPermissionService
    
    init(mediaPermissionService: MediaPermissionService = MediaPermissionService()) {
        self.mediaPermissionService = mediaPermissionService
    }
    
    func execute() throws -> Result<Bool, GalleryPermissionErrorService> {
        let result = self.mediaPermissionService.execute()
        if result == nil {
            throw GalleryPermissionErrorService(message: "Error on Gallery Permission Request: Permission Denied")
        }
        return .success(result!)
    }
}
