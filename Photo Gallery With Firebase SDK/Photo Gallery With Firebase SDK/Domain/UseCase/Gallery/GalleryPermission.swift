//
//  GalleryPermission.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 01/11/22.
//

import Foundation

struct GalleryPermission: IGalleryPermission {
    let drive: IGalleryPermissionDrive
    
    init(drive: IGalleryPermissionDrive = GalleryPermissionDrive()) {
        self.drive = drive
    }
    
    func execute() -> Result<Bool, GalleryPermissionErrorUseCase> {
        let result = self.drive.execute()
        return result
    }
}
