//
//  StringExtensionTest.swift
//  Photo Gallery App UiKitTests
//
//  Created by Paulo Antonelli on 13/12/22.
//

import XCTest
@testable import Photo_Gallery_App_UiKit

class StringExtensionTest: XCTestCase {
    let imageNameAndExtensionMock = "image-abc-123.jpeg"
    let imageNameAndExtensionRepeatMock = "image-abc-123.jpeg"
    
    func testExtractImageNameFromString() throws {
        let result = self.imageNameAndExtensionMock.extractImageNameFromString()
        assert(result == "image-abc-123")
    }
    
    func testExtractImageFormatFromString() throws {
        let result = self.imageNameAndExtensionRepeatMock.extractImageFormatFromString()
        assert(result == "jpeg")
    }
}
