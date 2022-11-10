//
//  DeleteMediaDrive.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 10/11/22.
//

import Foundation

struct DeleteMediaDrive: IDeleteMediaDrive {
    let service: IDeleteMediaService
    
    init(service: IDeleteMediaService = DeleteMediaService()) {
        self.service = service
    }
    
    func execute(imageName: String, imageExtension: String) async -> Result<Bool, DeleteMediaErrorUseCase> {
        do {
            let result = try await self.service.execute(imageName: imageName, imageExtension: imageExtension)
            return .success(result)
        } catch let error as DeleteMediaErrorService {
            return .failure(error)
        } catch {
            return .failure(DeleteMediaErrorDrive(message: "Error on DeleteMediaErrorDrive: \(error.localizedDescription)"))
        }
    }
}
