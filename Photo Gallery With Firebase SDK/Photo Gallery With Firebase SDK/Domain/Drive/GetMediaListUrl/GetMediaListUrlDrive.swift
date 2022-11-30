//
//  GetMediaListDrive.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 10/11/22.
//

import Foundation

public struct GetMediaListUrlDrive: IGetMediaListUrlDrive {
    let service: IGetMediaListUrlService
    
    public init(service: IGetMediaListUrlService = GetMediaListUrlService(firebaseStorageService: DependencyInjection.get(IFirebaseStorageService.self)!)) {
        self.service = service
    }
    
    public func execute() async -> Result<Array<URL>, GetMediaListUrlErrorUseCase> {
        do {
            let result = try await self.service.execute()
            return .success(result)
        } catch let error as GetMediaListUrlErrorService {
            return .failure(error)
        } catch {
            return .failure(GetMediaListUrlErrorDrive(message: "Error on GetMediaListDrive: \(error.localizedDescription)"))
        }
    }
}
