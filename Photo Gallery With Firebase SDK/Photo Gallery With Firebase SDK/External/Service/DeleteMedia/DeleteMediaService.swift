//
//  DeleteMediaService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 10/11/22.
//

import Foundation

public struct DeleteMediaService: IDeleteMediaService {
    let firebaseStorageService: IFirebaseStorageService
    
    public init(firebaseStorageService: IFirebaseStorageService = FirebaseStorageService()) {
        self.firebaseStorageService = firebaseStorageService
    }
    
    public func execute(imageName: String, imageExtension: String) async throws -> Bool {
        do {
            let result = try await self.firebaseStorageService.delete(imageName: imageName, imageExtension: imageExtension)
            return result
        } catch {
            throw DeleteMediaErrorService(message: "Error on DeleteMediaErrorService: \(error.localizedDescription)")
        }
    }
}
