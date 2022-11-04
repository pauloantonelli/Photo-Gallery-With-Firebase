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
   
    func initDependency(authorizationStatus: AVAuthorizationStatus = AVAuthorizationStatus.authorized) -> Void {
        self.service = CameraPermissionService(authorizationStatus: authorizationStatus)
    }
    
    func testCameraPermissionWithoutErrors() async throws {
        self.initDependency()
        let result = try await self.service.execute().get()
        XCTAssert(result == true)
    }
    
    func testCameraPermissionWithDeniedStatus() async throws {
        self.initDependency(authorizationStatus: AVAuthorizationStatus.denied)
        let result = try await self.service.execute().get()
        XCTAssert(result == false)
    }
    
    func testCameraPermissionWithRestrictedStatus() async throws {
        self.initDependency(authorizationStatus: AVAuthorizationStatus.restricted)
        let result = try await self.service.execute().get()
        XCTAssert(result == false)
    }
    
    func testCameraPermissionWithNotDeterminedStatus() async throws {
        self.initDependency(authorizationStatus: AVAuthorizationStatus.notDetermined)
        let result = try await self.service.execute().get()
        XCTAssert(result == true)
    }
    
    func testCameraPermissionWithFailureError() async throws {
        self.initDependency(authorizationStatus: AVAuthorizationStatus.init(rawValue: -1)!)
        do {
        let _ = try await self.service.execute().get()
        } catch {
            XCTAssert(error is CameraPermissionErrorService)
        }
    }
}
