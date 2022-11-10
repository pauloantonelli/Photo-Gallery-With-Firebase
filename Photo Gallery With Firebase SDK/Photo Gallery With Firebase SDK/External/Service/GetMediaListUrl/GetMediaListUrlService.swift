//
//  GetMediaListService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 10/11/22.
//

import Foundation

struct GetMediaListService: IGetMediaListUrlService {
    let firebaseStorageService: IFirebaseStorageService
    
    init(firebaseStorageService: IFirebaseStorageService = FirebaseStorageService()) {
        self.firebaseStorageService = firebaseStorageService
    }
    
    func execute() async throws -> Array<URL> {
        do {
            let result = try await self.firebaseStorageService.getList()
            return result
        } catch {
            throw GetMediaListUrlErrorService(message: "Error on GetMediaListService: \(error.localizedDescription)")
        }
    }
}
