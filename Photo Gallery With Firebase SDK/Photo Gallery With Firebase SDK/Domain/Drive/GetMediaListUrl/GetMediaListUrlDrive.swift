//
//  GetMediaListDrive.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 10/11/22.
//

import Foundation

struct GetMediaListUrlDrive: IGetMediaListUrlDrive {
    let service: IGetMediaListUrlService
    
    init(service: IGetMediaListUrlService = GetMediaListUrlService()) {
        self.service = service
    }
    
    func execute() async -> Result<Array<URL>, GetMediaListUrlErrorUseCase> {
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
