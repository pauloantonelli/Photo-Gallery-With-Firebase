//
//  SaveMediaService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 08/11/22.
//

import Foundation
import UIKit

public struct SaveMediaService: ISaveMediaService {
    let mediaFileService: IMediaFileService
    let firebaseStorageService: IFirebaseStorageService
    
    public init(mediaFileService: IMediaFileService = MediaFileService(), firebaseStorageService: IFirebaseStorageService = FirebaseStorageService()) {
        self.mediaFileService = mediaFileService
        self.firebaseStorageService = firebaseStorageService
    }
    
    public func execute(fileName: String, image: UIImage) async throws -> Bool {
        do {
            let imageName = self.mediaFileService.save(fileName: fileName, image: image)
            guard let safeImageName = imageName else {
                throw SaveMediaErrorDrive(message: "Error on SaveMediaService: file path is nil")
            }
            let filePath = self.mediaFileService.filePath(fileName: safeImageName)
            let result = try await self.firebaseStorageService.add(imagePath: filePath, imageName: fileName, imageExtension: "jpeg")
            if result == nil {
                throw SaveMediaErrorDrive(message: "Error on SaveMediaService: firebase add is nil")
            }
            return result!
        } catch {
            throw SaveMediaErrorDrive(message: "Error on SaveMediaService: file path is nil \(error.localizedDescription)")
        }
    }
}
