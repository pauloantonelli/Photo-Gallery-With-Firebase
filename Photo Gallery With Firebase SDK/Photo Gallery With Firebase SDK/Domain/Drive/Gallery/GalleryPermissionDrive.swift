//
//  GalleryPermissionDrive.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 01/11/22.
//

import Foundation

struct GalleryPermissionDrive: IGalleryPermissionDrive {
    let service: IGalleryPermissionService
    
    init(service: IGalleryPermissionService = GalleryPermissionService()) {
        self.service = service
    }
    
    func execute() async -> Result<Bool, GalleryPermissionErrorUseCase> {
        do {
            let result = try self.service.execute().get()
            return .success(result)
        } catch let error as GalleryPermissionErrorService {
            return .failure(error)
        } catch {
            return .failure(GalleryPermissionErrorDrive(message: "Error on GalleryPermissionErrorDrive"))
        }
    }
}
