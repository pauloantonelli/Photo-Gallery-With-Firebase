//
//  GalleryPermissionService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 01/11/22.
//

import Foundation
import PhotosUI

struct GalleryPermissionService: IGalleryPermissionService {
    var authorizationStatus: PHAuthorizationStatus
    
    init(authorizationStatus: PHAuthorizationStatus =  PHPhotoLibrary.authorizationStatus(for: .readWrite)) {
        self.authorizationStatus = authorizationStatus
    }
    
    func execute() async -> Result<Bool, GalleryPermissionErrorService> {
        let result = self.authorizationStatus
        if result == .notDetermined {
            let permission = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
            let result = await self.notDeterminedHandler(status: permission)
            return result
        }
        return self.statusHandler(status: result)
    }
}

extension GalleryPermissionService {
    func notDeterminedHandler(status: PHAuthorizationStatus) async -> Result<Bool, GalleryPermissionErrorService> {
        let permission = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
        let result = self.statusHandler(status: permission)
        return result
    }
    
    func statusHandler(status: PHAuthorizationStatus) -> Result<Bool, GalleryPermissionErrorService> {
        if status == .denied {
            return .success(false)
        }
        if status == .restricted {
            return .success(false)
        }
        if status == .limited {
            return .success(false)
        }
        if status == .authorized {
            return .success(true)
        }
        return .failure(GalleryPermissionErrorService(message: "Error on Gallery Permission Request"))
    }
}
