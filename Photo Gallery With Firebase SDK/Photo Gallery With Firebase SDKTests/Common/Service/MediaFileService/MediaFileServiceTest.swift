//
//  MediaFileServiceTest.swift
//  Photo Gallery With Firebase SDKTests
//
//  Created by Paulo Antonelli on 08/11/22.
//

import XCTest
import UIKit
@testable import Photo_Gallery_With_Firebase_SDK

class MediaFileServiceTest: XCTestCase {
    var service: MediaFileService!
    
    func initDependecy() -> Void {
        self.service = MediaFileService()
    }
    
    func testSaveFileWithoutErrors() throws {
        self.initDependecy()
        let fileName: String = "test-file"
        let image: UIImage = UIImage(systemName: "pencil")!
        let result = self.service.save(fileName: fileName, image: image)
        XCTAssert(result != nil)
        XCTAssert(result == fileName)
    }
    
    func testLoadFileWithoutErrors() throws {
        self.initDependecy()
        let fileName: String = "test-file"
        let result = self.service.load(fileName: fileName)
        XCTAssert(result != nil)
        XCTAssert(result is UIImage)
    }
    
    func testFilePathWithoutErrors() throws {
        self.initDependecy()
        let fileName: String = "test-file"
        let result = self.service.filePath(fileName: fileName)
        print("result \(result)")
        XCTAssert(result is URL)
    }
}
