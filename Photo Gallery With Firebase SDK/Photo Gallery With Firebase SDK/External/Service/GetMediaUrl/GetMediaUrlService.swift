//
//  GetMediaUrlService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 09/11/22.
//

import Foundation

struct GetMediaUrlService: IGetMediaUrlService {
    let firebaseStorageService: IFirebaseStorageService
    
    init(firebaseStorageService: IFirebaseStorageService = FirebaseStorageService()) {
        self.firebaseStorageService = firebaseStorageService
    }
    
    func execute(imageName: String, imageExtension: String) async throws -> URL {
        let result = await self.firebaseStorageService.get(imageName: imageName, imageExtension: imageExtension)
        guard let url = result else {
            throw GetMediaUrlErrorService(message: "Error on GetMediaUrlService: URL is nil")
        }
        return url
    }
}
