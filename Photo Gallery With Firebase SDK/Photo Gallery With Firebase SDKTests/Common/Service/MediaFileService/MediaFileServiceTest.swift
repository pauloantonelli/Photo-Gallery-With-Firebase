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
    let fileName: String = "test-file"
    let image: UIImage = UIImage(systemName: "pencil")!
    
    func verifyLocalFileExist() -> Void {
        let _ = self.service.save(fileName: self.fileName, image: self.image)
    }
    
    func initDependecy() -> Void {
        self.service = MediaFileService()
        self.verifyLocalFileExist()
    }
    
    func testSaveFileWithoutErrors() throws {
        self.initDependecy()
        let result = self.service.save(fileName: self.fileName, image: self.image)
        XCTAssert(result != nil)
        XCTAssert(result == self.fileName)
    }
    
    func testLoadFileWithoutErrors() throws {
        self.initDependecy()
        let result = try self.service.load(fileName: self.fileName)
        XCTAssert(result != nil)
    }
    
    func testFilePathWithoutErrors() throws {
        self.initDependecy()
        let result = self.service.filePath(fileName: self.fileName)
        print("result \(result)")
        XCTAssert(result is URL)
    }
}
