//
//  SaveMediaUseCaseTest.swift
//  Photo Gallery With Firebase SDKTests
//
//  Created by Paulo Antonelli on 08/11/22.
//

import XCTest
@testable import Photo_Gallery_With_Firebase_SDK

struct SaveMediaDriveMock: ISaveMediaDrive {
    func execute(fileName: String, image: UIImage) async -> Result<Bool, SaveMediaErrorUseCase> {
        return .success(true)
    }
}

class SaveMediaUseCaseTest: XCTestCase {
    var usecase: ISaveMediaUseCase!
   
    func initDependency(drive: ISaveMediaDrive = SaveMediaDriveMock()) -> Void {
        self.usecase = SaveMediaUseCase(drive: drive)
    }
    
    func testUsecaseWithoutError() async throws {
        self.initDependency()
        let fileName: String = "test-file"
        let result = try await self.usecase.execute(fileName: fileName, image: UIImage(systemName: "pencil")!).get()
        XCTAssert(result == true)
    }
    
    func testUsecaseWithFileNameError() async throws {
        self.initDependency()
        let fileName: String = ""
        do {
            let _ = try await self.usecase.execute(fileName: fileName, image: UIImage(systemName: "pencil")!).get()
        } catch {
            XCTAssert(error is SaveMediaErrorUseCase)
        }
    }
}
