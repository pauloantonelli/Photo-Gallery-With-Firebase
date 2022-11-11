//
//  CameraPermittion.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 31/10/22.
//

import Foundation

public struct CameraPermissionUseCase: ICameraPermissionUseCase {
    let drive: ICameraPermissionDrive
    
    init(drive: ICameraPermissionDrive = CameraPermissionDrive()) {
        self.drive = drive
    }
    
    public func execute() async -> Result<Bool, CameraPermissionErrorUseCase> {
        let result = await self.drive.execute()
        return result
    }
}

