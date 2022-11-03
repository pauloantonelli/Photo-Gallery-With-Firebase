//
//  GalleryPermissionServiceTest.swift
//  Photo Gallery With Firebase SDKTests
//
//  Created by Paulo Antonelli on 02/11/22.
//

import XCTest
import PhotosUI
@testable import Photo_Gallery_With_Firebase_SDK

class GalleryPermissionServiceTest: XCTestCase {
    var service: GalleryPermissionService!
   
    func initDependency(authorizationStatus: PHAuthorizationStatus = PHAuthorizationStatus.authorized) -> Void {
        self.service = GalleryPermissionService(authorizationStatus: authorizationStatus)
    }
    
    func testGalleryPermissionWithoutErrors() async throws {
        self.initDependency()
        let result = try await self.service.execute().get()
        XCTAssert(result == true)
    }
    
    func testGalleryPermissionWithDeniedStatus() async throws {
        self.initDependency(authorizationStatus: PHAuthorizationStatus.denied)
        let result = try await self.service.execute().get()
        XCTAssert(result == false)
    }
    
    func testGalleryPermissionWithRestrictedStatus() async throws {
        self.initDependency(authorizationStatus: PHAuthorizationStatus.restricted)
        let result = try await self.service.execute().get()
        XCTAssert(result == false)
    }
    
    func testGalleryPermissionWithLimitedStatus() async throws {
        self.initDependency(authorizationStatus: PHAuthorizationStatus.limited)
        let result = try await self.service.execute().get()
        XCTAssert(result == false)
    }
    
    func testGalleryPermissionWithFailureError() async throws {
        self.initDependency(authorizationStatus: PHAuthorizationStatus.init(rawValue: -1)!)
        do {
        let _ = try await self.service.execute().get()
        } catch {
            XCTAssert(error is GalleryPermissionErrorService)
        }
    }
}
