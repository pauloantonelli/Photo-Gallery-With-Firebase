//
//  GetMediaListUrlServiceTest.swift
//  Photo Gallery With Firebase SDKTests
//
//  Created by Paulo Antonelli on 10/11/22.
//

import XCTest
import FirebaseStorage
@testable import Photo_Gallery_With_Firebase_SDK

struct GetMediaListUrlServiceMock: IFirebaseStorageService {
    func add(imagePath: String, imageName: String, imageExtension: String) async -> Bool? {
        return true
    }
    
    func get(imageName: String, imageExtension: String) async -> URL? {
        return URL(fileURLWithPath: "//")
    }
    
    func delete(imageName: String, imageExtension: String) async -> Bool {
        return true
    }
    
    func download(fromURL: String, completion: @escaping (UIImage?) -> Void) {
        completion(UIImage(systemName: "pencil"))
    }

    func getList() async throws -> Array<URL> {
        return []
    }
    
    func storageMetadataFactory(imageName: String, imageExtension: String) -> StorageMetadata {
        return StorageMetadata()
    }
}
struct GetMediaListUrlServiceErrorMock: IFirebaseStorageService {
    func add(imagePath: String, imageName: String, imageExtension: String) async -> Bool? {
        return nil
    }
    
    func get(imageName: String, imageExtension: String) async -> URL? {
        return nil
    }
    
    func delete(imageName: String, imageExtension: String) async -> Bool {
        return false
    }
    
    func download(fromURL: String, completion: @escaping (UIImage?) -> Void) {
        completion(nil)
    }
    
    func getList() async throws -> Array<URL> {
        return []
    }
    
    func storageMetadataFactory(imageName: String, imageExtension: String) -> StorageMetadata {
        return StorageMetadata()
    }
}

class GetMediaListUrlServiceTest: XCTestCase {
    var service: IGetMediaListUrlService!
    
    func initDependency(firebaseStorageService: IFirebaseStorageService = GetMediaListUrlServiceMock()) -> Void {
        self.service = GetMediaListUrlService(firebaseStorageService: firebaseStorageService)
    }
    
    func testGetMediaListUrlServiceWithoutErrors() async throws {
        self.initDependency()
        let result = try await self.service.execute()
        XCTAssert(result is Array<URL>)
    }
    
    func testGetMediaListUrlServiceWithUrlError() async throws {
        self.initDependency(firebaseStorageService: GetMediaListUrlServiceErrorMock())
        do {
            let _ = try await self.service.execute()
        } catch {
            XCTAssert(error is GetMediaListUrlErrorService)
        }
    }
}
