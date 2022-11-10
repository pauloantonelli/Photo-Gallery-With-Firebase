//
//  DeleteMediaUseCaseTest.swift
//  Photo Gallery With Firebase SDKTests
//
//  Created by Paulo Antonelli on 10/11/22.
//

import XCTest
@testable import Photo_Gallery_With_Firebase_SDK

struct DeleteMediaDriveMock: IDeleteMediaDrive {
    func execute(imageName: String, imageExtension: String) async -> Result<Bool, DeleteMediaErrorUseCase> {
        return .success(true)
    }
}

class DeleteMediaUseCaseTest: XCTestCase {
    var usecase: IDeleteMediaUseCase!
    
    func initDependency(drive: IDeleteMediaDrive = DeleteMediaDriveMock()) -> Void {
        self.usecase = DeleteMediaUseCase(drive: drive)
    }
    
    func testDeleteMediaUseCaseWithoutErrors() async throws {
        self.initDependency()
        let result = try await self.usecase.execute(imageName: "test-file", imageExtension: "jpeg").get()
        XCTAssert(result == true)
    }
    
    func testDeleteMediaUseCaseWithImageNameError() async throws {
        self.initDependency()
        do {
            let _ = try await self.usecase.execute(imageName: "", imageExtension: "jpeg").get()
        } catch {
            XCTAssert(error is DeleteMediaErrorUseCase)
        }
    }
    
    func testDeleteMediaUseCaseWithImageExtensionError() async throws {
        self.initDependency()
        do {
            let _ = try await self.usecase.execute(imageName: "test-file", imageExtension: "").get()
        } catch {
            XCTAssert(error is DeleteMediaErrorUseCase)
        }
    }
}
