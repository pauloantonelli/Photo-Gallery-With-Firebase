//
//  GetMediaListDrive.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 10/11/22.
//

import Foundation

struct GetMediaListDrive: IGetMediaListDrive {
    let service: IGetMediaListService
    
    init(service: IGetMediaListService = GetMediaListService()) {
        self.service = service
    }
    
    func execute() async -> Result<Array<URL>, GetMediaListErrorUseCase> {
        do {
            let result = try await self.service.execute()
            return .success(result)
        } catch let error as GetMediaListErrorService {
            return .failure(error)
        } catch {
            return .failure(GetMediaListErrorDrive(message: "Error on GetMediaListDrive: \(error.localizedDescription)"))
        }
    }
}
