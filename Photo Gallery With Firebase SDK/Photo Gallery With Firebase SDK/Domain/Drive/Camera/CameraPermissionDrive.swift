//
//  CameraPermissionDrive.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 01/11/22.
//

import Foundation

struct CameraPermissionDrive: ICameraPermissionDrive {
    let service: ICameraPermissionService
    
    init(service: ICameraPermissionService = CameraPermissionService()) {
        self.service = service
    }
    
    func execute() async -> Result<Bool, CameraPermissionErrorUseCase> {
        do {
            let result = try await self.service.execute().get()
            return .success(result)
        } catch let error as CameraPermissionErrorService {
            return .failure(error)
        } catch {
            return .failure(CameraPermissionErrorDrive(message: "Error on CameraPermissionErrorDrive"))
        }
    }
}
