//
//  CameraPermissionTest.swift
//  Photo Gallery With Firebase SDKTests
//
//  Created by Paulo Antonelli on 01/11/22.
//

import XCTest
@testable import Photo_Gallery_With_Firebase_SDK

class CameraPermissionUseCaseTest: XCTestCase {
    var service: CameraPermissionService!
    var drive: CameraPermissionDrive!
    var usecase: CameraPermissionUseCase!
    
    func initDependency() -> Void {
        self.service = CameraPermissionService()
        self.drive = CameraPermissionDrive()
        self.usecase = CameraPermissionUseCase()
    }
    
    func testCameraPermissionWithoutErrors() async throws {
        self.initDependency()
        do {
            let result = try await self.usecase.execute().get()
            XCTAssert(result == true)
        } catch {
        }
    }
}
