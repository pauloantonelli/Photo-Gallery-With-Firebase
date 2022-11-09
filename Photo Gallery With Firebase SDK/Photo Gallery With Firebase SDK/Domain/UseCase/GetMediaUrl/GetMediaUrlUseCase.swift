//
//  GetMediaUrlUseCase.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 09/11/22.
//

import Foundation

struct GetMediaUrlUseCase: IGetMediaUrlUseCase {
    var drive: IGetMediaUrlDrive
    
    init(drive: IGetMediaUrlDrive = GetMediaUrlDrive()) {
        self.drive = drive
    }
    
    func execute(imageName: String, imageExtension: String) async -> Result<URL, GetMediaUrlErrorUseCase> {
        if imageName.isEmpty {
            return .failure(GetMediaUrlErrorUseCase(message: "Error on GetMediaUrlUseCase: imageName is empty"))
        }
        if imageExtension.isEmpty {
            return .failure(GetMediaUrlErrorUseCase(message: "Error on GetMediaUrlUseCase: imageExtension is empty"))
        }
        let result = await self.drive.execute(imageName: imageName, imageExtension: imageExtension)
        return result
    }
}
