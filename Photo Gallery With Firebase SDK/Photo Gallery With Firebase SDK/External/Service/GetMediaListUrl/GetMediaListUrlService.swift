//
//  GetMediaListService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 10/11/22.
//

import Foundation

public struct GetMediaListUrlService: IGetMediaListUrlService {
    let firebaseStorageService: IFirebaseStorageService
    
    public init(firebaseStorageService: IFirebaseStorageService) {
        self.firebaseStorageService = firebaseStorageService
    }
    
    public func execute() async throws -> Array<URL> {
        do {
            let result = try await self.firebaseStorageService.getList()
            return result
        } catch {
            throw GetMediaListUrlErrorService(message: "Error on GetMediaListService: \(error.localizedDescription)")
        }
    }
}
