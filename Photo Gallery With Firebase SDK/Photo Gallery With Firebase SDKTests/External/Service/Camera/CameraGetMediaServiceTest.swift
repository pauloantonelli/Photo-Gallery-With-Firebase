//
//  CameraGetMediaServiceTest.swift
//  Photo Gallery With Firebase SDKTests
//
//  Created by Paulo Antonelli on 02/11/22.
//

import XCTest
@testable import Photo_Gallery_With_Firebase_SDK

class CameraGetMediaServiceTest: XCTestCase {
    var service: CameraGetMediaService!
    
    func initDependency() -> Void {
        self.service = CameraGetMediaService()
    }
    
    func testCameraGetMediaServiceWithoutErrors() async throws {
        self.initDependency()
        do {
            let result = try await self.service.execute()
            XCTAssert(result is UIImage)
        } catch {
        }
    }
}
