//
//  GalleryPermissionTest.swift
//  Photo Gallery With Firebase SDKTests
//
//  Created by Paulo Antonelli on 01/11/22.
//

import XCTest
@testable import Photo_Gallery_With_Firebase_SDK

struct GalleryPermissionServiceMock: IGalleryPermissionService {
    func execute() async -> Result<Bool, GalleryPermissionErrorService> {
        return .success(true)
    }
}

class GalleryPermissionUseCaseTest: XCTestCase {
    var service: IGalleryPermissionService!
    var drive: GalleryPermissionDrive!
    var usecase: GalleryPermissionUseCase!
    
    func initDependency() -> Void {
        self.service = GalleryPermissionServiceMock()
        self.drive = GalleryPermissionDrive(service: self.service)
        self.usecase = GalleryPermissionUseCase(drive: self.drive)
    }
    
    func testGalleryPermissionWithoutErrors() async throws {
        self.initDependency()
        do {
            let result = try await self.usecase.execute().get()
            XCTAssert(result == true)
        } catch {
        }
    }
}
