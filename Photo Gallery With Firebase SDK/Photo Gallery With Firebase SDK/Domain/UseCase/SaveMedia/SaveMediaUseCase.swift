//
//  SaveMedia.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 08/11/22.
//

import Foundation
import UIKit

public struct SaveMediaUseCase: ISaveMediaUseCase {
    let drive: ISaveMediaDrive
    
    init(drive: ISaveMediaDrive = SaveMediaDrive()) {
        self.drive = drive
    }
    
    public func execute(fileName: String, image: UIImage) async -> Result<Bool, SaveMediaErrorUseCase> {
        if fileName.isEmpty {
            return .failure(SaveMediaErrorUseCase(message: "Erro on SaveMediaUseCase: fileName cannot be empty"))
        }
        if image.size.width == 0.0 {
            return .failure(SaveMediaErrorUseCase(message: "Erro on SaveMediaUseCase: image cannot be empty"))
        }
        let result = await self.drive.execute(fileName: fileName, image: image)
        return result
    }
}
