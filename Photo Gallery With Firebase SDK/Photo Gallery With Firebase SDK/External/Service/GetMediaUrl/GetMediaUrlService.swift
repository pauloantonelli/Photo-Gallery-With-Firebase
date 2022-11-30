//
//  GetMediaUrlService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 09/11/22.
//

import Foundation

public struct GetMediaUrlService: IGetMediaUrlService {
    let firebaseStorageService: IFirebaseStorageService
    
    public init(firebaseStorageService: IFirebaseStorageService) {
        self.firebaseStorageService = firebaseStorageService
    }
    
    public func execute(imageName: String, imageExtension: String) async throws -> URL {
        do {
            let result = try await self.firebaseStorageService.get(imageName: imageName, imageExtension: imageExtension)
            guard let url = result else {
                throw GetMediaUrlErrorService(message: "Error on GetMediaUrlService: URL is nil")
            }
            return url
        } catch {
            throw GetMediaUrlErrorService(message: "Error on GetMediaUrlErrorService: \(error.localizedDescription)")
        }
    }
}
