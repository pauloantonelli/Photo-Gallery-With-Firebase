//
//  GalleryPermission.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 01/11/22.
//

import Foundation

public struct GalleryPermissionUseCase: IGalleryPermissionUseCase {
    let drive: IGalleryPermissionDrive
    
    public init(drive: IGalleryPermissionDrive = GalleryPermissionDrive()) {
        self.drive = drive
    }
    
    public func execute() async -> Result<Bool, GalleryPermissionErrorUseCase> {
        let result = await self.drive.execute()
        return result
    }
}
