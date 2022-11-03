//
//  GalleryPermission.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 01/11/22.
//

import Foundation

struct GalleryPermissionUseCase: IGalleryPermissionUseCase {
    let drive: IGalleryPermissionDrive
    
    init(drive: IGalleryPermissionDrive = GalleryPermissionDrive()) {
        self.drive = drive
    }
    
    func execute() async -> Result<Bool, GalleryPermissionErrorUseCase> {
        let result = await self.drive.execute()
        return result
    }
}
