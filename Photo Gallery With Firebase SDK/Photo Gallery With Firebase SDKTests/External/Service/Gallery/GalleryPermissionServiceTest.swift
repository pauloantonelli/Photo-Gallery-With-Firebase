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
   
    func initDependency(mediaPermissionService: MediaPermissionService = MediaPermissionService()) -> Void {
        self.service = GalleryPermissionService(mediaPermissionService: mediaPermissionService)
    }
    
    func testGalleryPermissionWithoutErrors() async throws {
        var mediaPermissionService = MediaPermissionService()
        mediaPermissionService.authorizationStatus = AVAuthorizationStatus.authorized
        self.initDependency(mediaPermissionService: mediaPermissionService)
        let result = try await self.service.execute().get()
        XCTAssert(result == true)
    }
    
    func testGalleryPermissionWithDeniedStatus() async throws {
        var mediaPermissionService = MediaPermissionService()
        mediaPermissionService.authorizationStatus = AVAuthorizationStatus.denied
        self.initDependency(mediaPermissionService: mediaPermissionService)
        do {
            let _ = try await self.service.execute().get()
        } catch {
            XCTAssert(error is GalleryPermissionErrorService)
        }
    }
    
    func testGalleryPermissionWithRestrictedStatus() async throws {
        var mediaPermissionService = MediaPermissionService()
        mediaPermissionService.authorizationStatus = AVAuthorizationStatus.restricted
        self.initDependency(mediaPermissionService: mediaPermissionService)
        let result = try await self.service.execute().get()
        XCTAssert(result == false)
    }
    
    func testGalleryPermissionWithFailureError() async throws {
        var mediaPermissionService = MediaPermissionService()
        mediaPermissionService.authorizationStatus = AVAuthorizationStatus.init(rawValue: -1)!
        self.initDependency(mediaPermissionService: mediaPermissionService)
        do {
        let _ = try await self.service.execute().get()
        } catch {
            XCTAssert(error is GalleryPermissionErrorService)
        }
    }
}
