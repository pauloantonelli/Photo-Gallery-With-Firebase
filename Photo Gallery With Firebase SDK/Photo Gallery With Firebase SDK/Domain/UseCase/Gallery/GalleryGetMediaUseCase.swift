//
//  GalleryGetMediaUseCase.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 02/11/22.
//

import Foundation
import UIKit

struct GalleryGetMediaUseCase: IGalleryGetMediaUseCase {
    let drive: GalleryGetMediaDrive
    
    init(drive: GalleryGetMediaDrive) {
        self.drive = drive
    }
    
    func execute() async -> Result<UIImage, GalleryGetMediaErrorUseCase> {
        let result = await self.drive.execute()
        return result
    }
}
