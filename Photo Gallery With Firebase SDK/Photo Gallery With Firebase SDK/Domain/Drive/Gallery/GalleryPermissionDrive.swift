//
//  GalleryPermissionDrive.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 01/11/22.
//

import Foundation

public struct GalleryPermissionDrive: IGalleryPermissionDrive {
    let service: IGalleryPermissionService
    
    public init(service: IGalleryPermissionService = GalleryPermissionService()) {
        self.service = service
    }
    
    public func execute() async -> Result<Bool, GalleryPermissionErrorUseCase> {
        do {
            let result = try await self.service.execute().get()
            return .success(result)
        } catch let error as GalleryPermissionErrorService {
            return .failure(error)
        } catch {
            return .failure(GalleryPermissionErrorDrive(message: "Error on GalleryPermissionErrorDrive"))
        }
    }
}
