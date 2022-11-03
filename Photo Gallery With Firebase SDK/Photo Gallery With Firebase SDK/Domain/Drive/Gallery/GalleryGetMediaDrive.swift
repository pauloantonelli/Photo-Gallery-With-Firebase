//
//  GalleryGetMediaDrive.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 02/11/22.
//

import Foundation
import UIKit

struct GalleryGetMediaDrive: IGalleryGetMediaDrive {
    let service: IGalleryGetMediaService
    
    init(service: GalleryGetMediaService = GalleryGetMediaService()) {
        self.service = service
    }
    
    func execute() async -> Result<UIImage, GalleryGetMediaErrorUseCase> {
        do {
            let result = try await self.service.execute()
            return .success(result)
        } catch let error as GalleryGetMediaErrorService {
            return .failure(error)
        } catch {
            return .failure(GalleryGetMediaErrorUseCase(message: "Error on GalleryGetMediaErrorUseCase \(error.localizedDescription)"))
        }
    }
}
