//
//  GetMediaUrlDrive.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 09/11/22.
//

import Foundation

struct GetMediaUrlDrive: IGetMediaUrlDrive {
    let service: IGetMediaUrlService
    
    init(service: IGetMediaUrlService = GetMediaUrlService()) {
        self.service = service
    }
    
    func execute(imageName: String, imageExtension: String) async -> Result<URL, GetMediaUrlErrorUseCase> {
        do {
            let result = try await self.service.execute(imageName: imageName, imageExtension: imageExtension)
            return .success(result)
        } catch let error as GetMediaUrlErrorService {
            return .failure(error)
        } catch {
            return .failure(GetMediaUrlErrorDrive(message: "Error on GetMediaUrlDrive: \(error.localizedDescription)"))
        }
    }
}
