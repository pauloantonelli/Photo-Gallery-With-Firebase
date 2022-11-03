//
//  CameraGetMediaUseCase.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 02/11/22.
//

import Foundation
import UIKit

struct CameraGetMediaUseCase: ICameraGetMediaUseCase {
    let drive: CameraGetMediaDrive
    
    init(drive: CameraGetMediaDrive) {
        self.drive = drive
    }
    
    func execute() async -> Result<UIImage, CameraGetMediaErrorUseCase> {
        let result = await self.drive.execute()
        return result
    }
}
