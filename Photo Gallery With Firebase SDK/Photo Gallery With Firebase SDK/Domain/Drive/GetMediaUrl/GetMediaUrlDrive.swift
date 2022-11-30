//
//  GetMediaUrlDrive.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 09/11/22.
//

import Foundation

public struct GetMediaUrlDrive: IGetMediaUrlDrive {
    let service: IGetMediaUrlService
    
    public init(service: IGetMediaUrlService = GetMediaUrlService(firebaseStorageService: DependencyInjection.get(IFirebaseStorageService.self)!)) {
        self.service = service
    }
    
    public func execute(imageName: String, imageExtension: String) async -> Result<URL, GetMediaUrlErrorUseCase> {
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
