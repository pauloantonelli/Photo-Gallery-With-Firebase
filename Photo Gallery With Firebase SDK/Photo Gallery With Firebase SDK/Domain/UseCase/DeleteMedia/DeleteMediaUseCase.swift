//
//  DeleteMediaUseCase.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 10/11/22.
//

import Foundation

public struct DeleteMediaUseCase: IDeleteMediaUseCase {
    let drive: IDeleteMediaDrive
    
    init(drive: IDeleteMediaDrive = DeleteMediaDrive()) {
        self.drive = drive
    }
    
    public func execute(imageName: String, imageExtension: String) async -> Result<Bool, DeleteMediaErrorUseCase> {
        if imageName.isEmpty {
            return .failure(DeleteMediaErrorUseCase(message: "Error on DeleteMediaErrorUseCase: imageName is empty"))
        }
        if imageExtension.isEmpty {
            return .failure(DeleteMediaErrorUseCase(message: "Error on DeleteMediaErrorUseCase: imageExtension is empty"))
        }
        let result = await self.drive.execute(imageName: imageName, imageExtension: imageExtension)
        return result
    }
}
