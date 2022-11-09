//
//  GetMediaUrlServiceTest.swift
//  Photo Gallery With Firebase SDKTests
//
//  Created by Paulo Antonelli on 09/11/22.
//

import XCTest
import FirebaseStorage
@testable import Photo_Gallery_With_Firebase_SDK

struct GetMediaUrlFirebaseStorageServiceMock: IFirebaseStorageService {
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
    
    func listMedia(completion: @escaping (Array<UIImage>) -> Void) async {
        completion([UIImage(systemName: "pencil")!])
    }
    
    func storageMetadataFactory(imageName: String, imageExtension: String) -> StorageMetadata {
        return StorageMetadata()
    }
}
struct GetMediaUrlFirebaseStorageServiceErrorMock: IFirebaseStorageService {
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
    
    func listMedia(completion: @escaping (Array<UIImage>) -> Void) async {
        completion([])
    }
    
    func storageMetadataFactory(imageName: String, imageExtension: String) -> StorageMetadata {
        return StorageMetadata()
    }
}

class GetMediaUrlServiceTest: XCTestCase {
    var service: IGetMediaUrlService!
    
    func initDependency(firebaseStorageService: IFirebaseStorageService = GetMediaUrlFirebaseStorageServiceMock()) -> Void {
        self.service = GetMediaUrlService(firebaseStorageService: firebaseStorageService)
    }
    
    func testGetMediaUrlServiceWithoutErrors() async throws {
        self.initDependency()
        let result = try await self.service.execute(imageName: "test-file", imageExtension: "jpeg")
        XCTAssert(result is URL)
    }
    
    func testGetMediaUrlServiceWithUrlError() async throws {
        self.initDependency(firebaseStorageService: GetMediaUrlFirebaseStorageServiceErrorMock())
        do {
            let _ = try await self.service.execute(imageName: "test-file", imageExtension: "jpeg")
        } catch {
            XCTAssert(error is GetMediaUrlErrorService)
        }
    }
}
