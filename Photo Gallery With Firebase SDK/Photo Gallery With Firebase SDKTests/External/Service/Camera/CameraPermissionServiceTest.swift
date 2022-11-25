//
//  CameraPermissionServiceTest.swift
//  Photo Gallery With Firebase SDKTests
//
//  Created by Paulo Antonelli on 01/11/22.
//

import XCTest
import AVFoundation
@testable import Photo_Gallery_With_Firebase_SDK

class CameraPermissionServiceTest: XCTestCase {
    var service: CameraPermissionService!
   
    func initDependency(mediaPermissionService: MediaPermissionService = MediaPermissionService()) -> Void {
        self.service = CameraPermissionService(mediaPermissionService: mediaPermissionService)
    }
    
    func testCameraPermissionWithoutErrors() async throws {
        self.initDependency()
        let result = try await self.service.execute().get()
        XCTAssert(result == true)
    }
    
    func testCameraPermissionWithDeniedStatus() async throws {
        let mediaPermissionService = MediaPermissionService()
        self.initDependency(mediaPermissionService: mediaPermissionService)
        do {
            let _ = try await self.service.execute().get()
        } catch {
            XCTAssert(error is CameraPermissionErrorService)
        }
    }
    
    func testCameraPermissionWithRestrictedStatus() async throws {
        var mediaPermissionService = MediaPermissionService()
        mediaPermissionService.authorizationStatus = AVAuthorizationStatus.restricted
        self.initDependency(mediaPermissionService: mediaPermissionService)
        do {
            let _ = try await self.service.execute().get()
        } catch {
            XCTAssert(error is CameraPermissionErrorService)
        }
    }
    
    func testCameraPermissionWithFailureError() async throws {
        var mediaPermissionService = MediaPermissionService()
        mediaPermissionService.authorizationStatus = AVAuthorizationStatus.init(rawValue: -1)!
        self.initDependency(mediaPermissionService: mediaPermissionService)
        do {
        let _ = try await self.service.execute().get()
        } catch {
            XCTAssert(error is CameraPermissionErrorService)
        }
    }
}
