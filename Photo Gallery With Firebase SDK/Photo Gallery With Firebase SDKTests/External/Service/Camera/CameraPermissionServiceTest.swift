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
    
    func testCameraPermissionWithoutErrors() throws {
        self.initDependency()
        let result = try self.service.execute().get()
        XCTAssert(result == true)
    }
    
    func testCameraPermissionWithDeniedStatus() throws {
        let mediaPermissionService = MediaPermissionService(authorizationStatus: AVAuthorizationStatus.denied)
        self.initDependency(mediaPermissionService: mediaPermissionService)
        do {
            let _ = try self.service.execute().get()
        } catch {
            XCTAssert(error is CameraPermissionErrorService)
        }
    }
    
    func testCameraPermissionWithRestrictedStatus() throws {
        let mediaPermissionService = MediaPermissionService(authorizationStatus: AVAuthorizationStatus.restricted)
        self.initDependency(mediaPermissionService: mediaPermissionService)
        do {
            let _ = try self.service.execute().get()
        } catch {
            XCTAssert(error is CameraPermissionErrorService)
        }
    }
    
    func testCameraPermissionWithFailureError() throws {
        let mediaPermissionService = MediaPermissionService(authorizationStatus: AVAuthorizationStatus.init(rawValue: -1)!)
        self.initDependency(mediaPermissionService: mediaPermissionService)
        do {
        let _ = try self.service.execute().get()
        } catch {
            XCTAssert(error is CameraPermissionErrorService)
        }
    }
}
