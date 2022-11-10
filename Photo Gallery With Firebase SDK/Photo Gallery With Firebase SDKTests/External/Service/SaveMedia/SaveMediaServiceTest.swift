//
//  SaveMediaServiceTest.swift
//  Photo Gallery With Firebase SDKTests
//
//  Created by Paulo Antonelli on 08/11/22.
//

import XCTest
import FirebaseStorage
@testable import Photo_Gallery_With_Firebase_SDK

struct SaveMediaFirebaseStorageServiceMock: IFirebaseStorageService {
    func add(imagePath: String, imageName: String, imageExtension: String) async throws -> Bool? {
        return true
    }
    
    func get(imageName: String, imageExtension: String) async throws -> URL? {
        return nil
    }
    
    func delete(imageName: String, imageExtension: String) async throws -> Bool {
        return true
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
struct SaveMediaFirebaseStorageServiceErrorMock: IFirebaseStorageService {
    func add(imagePath: String, imageName: String, imageExtension: String) async -> Bool? {
        return nil
    }
    
    func get(imageName: String, imageExtension: String) async -> URL? {
        return nil
    }
    
    func delete(imageName: String, imageExtension: String) async -> Bool {
        return true
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
struct SaveMediaMediaFileServiceMock: IMediaFileService {
    var documentsUrl: URL
    
    func save(fileName: String, image: UIImage) -> String? {
        return fileName
    }
    
    func load(fileName: String) -> UIImage? {
        return nil
    }
    
    func filePath(fileName: String) -> URL {
        return URL(fileURLWithPath: fileName)
    }
}
struct SaveMediaMediaFileServiceErrorMock: IMediaFileService {
    var documentsUrl: URL
    
    func save(fileName: String, image: UIImage) -> String? {
        return nil
    }
    
    func load(fileName: String) -> UIImage? {
        return nil
    }
    
    func filePath(fileName: String) -> URL {
        return URL(fileURLWithPath: fileName)
    }
}

class SaveMediaServiceTest: XCTestCase {
    var mediaFileService: IMediaFileService!
    var firebaseStorageService: IFirebaseStorageService!
    var service: ISaveMediaService!
    
    func initDependecy(
        mediaFileService: IMediaFileService = SaveMediaMediaFileServiceMock(documentsUrl: URL(fileURLWithPath: "//")),
        firebaseStorageService: IFirebaseStorageService = SaveMediaFirebaseStorageServiceMock()
    ) -> Void {
        self.service = SaveMediaService(
            mediaFileService: mediaFileService,
            firebaseStorageService: firebaseStorageService
        )
    }
    
    func testServiceWithoutError() async throws {
        self.initDependecy()
        let filePath: String = "test-file"
        let image: UIImage = UIImage(systemName: "pencil")!
        let result = try await self.service.execute(fileName: filePath, image: image)
        XCTAssert(result == true)
    }
    
    func testServiceWithFilePathError() async throws {
        self.initDependecy(
            mediaFileService: SaveMediaMediaFileServiceErrorMock(documentsUrl: URL(fileURLWithPath: "//")))
        let filePath: String = "test-file"
        let image: UIImage = UIImage(systemName: "pencil")!
        do {
            let _ = try await self.service.execute(fileName: filePath, image: image)
        } catch {
            XCTAssert(error is SaveMediaErrorDrive)
        }
    }
    
    func testServiceWithAddError() async throws {
        self.initDependecy(
            firebaseStorageService: SaveMediaFirebaseStorageServiceErrorMock())
        let filePath: String = "test-file"
        let image: UIImage = UIImage(systemName: "pencil")!
        do {
            let _ = try await self.service.execute(fileName: filePath, image: image)
        } catch {
            XCTAssert(error is SaveMediaErrorDrive)
        }
    }
}
