//
//  SaveMediaService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 08/11/22.
//

import Foundation
import UIKit

struct SaveMediaService: ISaveMediaService {
    let mediaFileService: IMediaFileService
    let firebaseStorageService: IFirebaseStorageService
    
    init(mediaFileService: IMediaFileService = MediaFileService(), firebaseStorageService: IFirebaseStorageService = FirebaseStorageService()) {
        self.mediaFileService = mediaFileService
        self.firebaseStorageService = firebaseStorageService
    }
    
    func execute(fileName: String, image: UIImage) async throws -> Bool {
        do {
            let filePath = self.mediaFileService.save(fileName: fileName, image: image)
            if filePath == nil {
                throw SaveMediaErrorDrive(message: "Error on SaveMediaService: file path is nil")
            }
            let result = try await self.firebaseStorageService.add(imagePath: filePath!, imageName: fileName, imageExtension: "jpeg")
            if result == nil {
                throw SaveMediaErrorDrive(message: "Error on SaveMediaService: firebase add is nil")
            }
            return result!
        } catch {
            throw SaveMediaErrorDrive(message: "Error on SaveMediaService: file path is nil \(error.localizedDescription)")
        }
    }
}
