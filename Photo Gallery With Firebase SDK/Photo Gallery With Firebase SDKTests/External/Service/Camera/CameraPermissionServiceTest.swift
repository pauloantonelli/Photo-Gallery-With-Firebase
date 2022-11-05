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
    
    func testCameraPermissionWithoutErrors() throws {
        self.initDependency()
        let result = try self.service.execute().get()
        XCTAssert(result == true)
    }
    
    func testCameraPermissionWithDeniedStatus() throws {
        self.initDependency(authorizationStatus: AVAuthorizationStatus.denied)
        let result = try self.service.execute().get()
        XCTAssert(result == false)
    }
    
    func testCameraPermissionWithRestrictedStatus() throws {
        self.initDependency(authorizationStatus: AVAuthorizationStatus.restricted)
        let result = try self.service.execute().get()
        XCTAssert(result == false)
    }
    
    func testCameraPermissionWithFailureError() throws {
        self.initDependency(authorizationStatus: AVAuthorizationStatus.init(rawValue: -1)!)
        do {
        let _ = try self.service.execute().get()
        } catch {
            XCTAssert(error is CameraPermissionErrorService)
        }
    }
}
