//
//  GalleryGetMediaServiceTest.swift
//  Photo Gallery With Firebase SDKTests
//
//  Created by Paulo Antonelli on 02/11/22.
//

import XCTest
@testable import Photo_Gallery_With_Firebase_SDK

class GalleryGetMediaServiceTest: XCTestCase {
    var service: GalleryGetMediaService!
    
    func initDependency() -> Void {
        self.service = GalleryGetMediaService()
    }
    
    func testGalleryGetMediaServiceWithoutErrors() async throws {
        self.initDependency()
        do {
            let result = try await self.service.execute()
            XCTAssert(result is UIImage)
        } catch {
        }
    }
}
