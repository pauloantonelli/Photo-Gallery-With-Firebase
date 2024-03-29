//
//  SaveMediaDrive.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 08/11/22.
//

import Foundation
import UIKit

public struct SaveMediaDrive: ISaveMediaDrive {
    let service: ISaveMediaService
    
    public init(service: ISaveMediaService = SaveMediaService()) {
        self.service = service
    }
    
    public func execute(fileName: String, image: UIImage) async -> Result<Bool, SaveMediaErrorUseCase> {
        do {
            let result = try await self.service.execute(fileName: fileName, image: image)
            return .success(result)
        } catch let error as SaveMediaErrorService {
            return .failure(error)
        } catch {
            return .failure(SaveMediaErrorDrive(message: "Error on SaveMediaErrorDrive: \(error.localizedDescription)"))
        }
    }
}
