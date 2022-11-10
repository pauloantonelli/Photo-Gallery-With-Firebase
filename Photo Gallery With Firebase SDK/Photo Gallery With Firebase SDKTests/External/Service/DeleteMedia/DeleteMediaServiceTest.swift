//
//  DeleteMediaServiceTest.swift
//  Photo Gallery With Firebase SDKTests
//
//  Created by Paulo Antonelli on 10/11/22.
//

import XCTest
import FirebaseStorage
@testable import Photo_Gallery_With_Firebase_SDK

struct DeleteMediaServiceFirebaseStorageServiceMock: IFirebaseStorageService {
    func add(imagePath: String, imageName: String, imageExtension: String) async throws -> Bool? {
        nil
    }
    
    func get(imageName: String, imageExtension: String) async throws -> URL? {
        nil
    }
    
    func delete(imageName: String, imageExtension: String) async throws -> Bool {
        true
    }
    
    func download(fromURL: String, completion: @escaping (UIImage?) -> Void) -> Void {
        completion(nil)
    }
    
    func getList() async throws -> Array<URL> {
        return []
    }
    
    func storageMetadataFactory(imageName: String, imageExtension: String) -> StorageMetadata {
        return StorageMetadata()
    }
}

struct DeleteMediaServiceFirebaseStorageServiceErrorMock: IFirebaseStorageService {
    func add(imagePath: String, imageName: String, imageExtension: String) async throws -> Bool? {
        nil
    }
    
    func get(imageName: String, imageExtension: String) async throws -> URL? {
        nil
    }
    
    func delete(imageName: String, imageExtension: String) async throws -> Bool {
        throw DeleteMediaErrorService(message: "Error")
    }
    
    func download(fromURL: String, completion: @escaping (UIImage?) -> Void) -> Void {
        completion(nil)
    }
    
    func getList() async throws -> Array<URL> {
        return []
    }
    
    func storageMetadataFactory(imageName: String, imageExtension: String) -> StorageMetadata {
        return StorageMetadata()
    }
}

class DeleteMediaServiceTest: XCTestCase {
    var service: IDeleteMediaService!
   
    func initDependency(firebaseStorageService: IFirebaseStorageService = DeleteMediaServiceFirebaseStorageServiceMock()) {
        self.service = DeleteMediaService(firebaseStorageService: firebaseStorageService)
    }
    
    func testDeleteMediaServiceWithoutErrors() async throws {
        self.initDependency()
        let result = try await self.service.execute(imageName: "test-file", imageExtension: "jpeg")
        XCTAssert(result == true)
    }
    
    func testDeleteMediaServiceWithError() async throws {
        self.initDependency(firebaseStorageService: DeleteMediaServiceFirebaseStorageServiceErrorMock())
        do {
            let _ = try await self.service.execute(imageName: "test-file", imageExtension: "jpeg")
        } catch {
            XCTAssert(error is DeleteMediaErrorService)
        }
    }
}
