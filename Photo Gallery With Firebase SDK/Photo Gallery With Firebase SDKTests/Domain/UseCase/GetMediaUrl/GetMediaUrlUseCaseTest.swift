//
//  GetMediaUrlTest.swift
//  Photo Gallery With Firebase SDKTests
//
//  Created by Paulo Antonelli on 09/11/22.
//

import XCTest
@testable import Photo_Gallery_With_Firebase_SDK

struct GetMediaUrlDriveMock: IGetMediaUrlDrive {
    func execute(imageName: String, imageExtension: String) async -> Result<URL, GetMediaUrlErrorUseCase> {
        return .success(URL(fileURLWithPath: "//"))
    }
}

class GetMediaUrlTest: XCTestCase {
    var usecase: IGetMediaUrlUseCase!
    
    func initDependency() -> Void {
        let drive: IGetMediaUrlDrive! = GetMediaUrlDriveMock()
        self.usecase = GetMediaUrlUseCase(drive: drive)
    }
    
    func testGetMediaUrlUseCaseWithoutErrors() async throws {
        self.initDependency()
        let result = try await self.usecase.execute(imageName: "test-file", imageExtension: "jpeg").get()
        XCTAssert(result is URL)
    }
    
    func testGetMediaUrlUseCaseWithImageNameError() async throws {
        self.initDependency()
        do {
        let _ = try await self.usecase.execute(imageName: "", imageExtension: "jpeg").get()
        } catch {
            XCTAssert(error is GetMediaUrlErrorUseCase)
        }
    }
    
    func testGetMediaUrlUseCaseWithImageExtensionError() async throws {
        self.initDependency()
        do {
        let _ = try await self.usecase.execute(imageName: "test-file", imageExtension: "").get()
        } catch {
            XCTAssert(error is GetMediaUrlErrorUseCase)
        }
    }
}
