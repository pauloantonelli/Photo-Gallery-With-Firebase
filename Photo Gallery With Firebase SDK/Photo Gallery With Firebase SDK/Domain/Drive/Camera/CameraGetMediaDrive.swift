//
//  CameraGetMediaDrive.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 02/11/22.
//

import Foundation
import UIKit

struct CameraGetMediaDrive: ICameraGetMediaDrive {
    let service: ICameraGetMediaService
    
    init(service: CameraGetMediaService = CameraGetMediaService()) {
        self.service = service
    }
    
    func execute() async -> Result<UIImage, CameraGetMediaErrorUseCase> {
        do {
            let result = try await self.service.execute()
            return .success(result)
        } catch let error as CameraGetMediaErrorService {
            return .failure(error)
        } catch {
            return .failure(CameraGetMediaErrorUseCase(message: "Error on CameraGetMediaErrorUseCase \(error.localizedDescription)"))
        }
    }
}
