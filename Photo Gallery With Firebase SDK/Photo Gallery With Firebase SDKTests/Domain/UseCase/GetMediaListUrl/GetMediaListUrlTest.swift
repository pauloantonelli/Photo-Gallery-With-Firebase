//
//  GetMediaListUrlTest.swift
//  Photo Gallery With Firebase SDKTests
//
//  Created by Paulo Antonelli on 10/11/22.
//

import XCTest
@testable import Photo_Gallery_With_Firebase_SDK

struct GetMediaListUrlDriveMock: IGetMediaListUrlDrive {
    func execute() async -> Result<Array<URL>, GetMediaListUrlErrorUseCase> {
        return .success([URL(string: "https://")!])
    }
}

class GetMediaListUrlUseCaseTest: XCTestCase {
    var usecase: IGetMediaListUrlUseCase!
    
    func initDependency() -> Void {
        let drive: IGetMediaListUrlDrive = GetMediaListUrlDriveMock()
        self.usecase = GetMediaListUrlUseCase(drive: drive)
    }
    
    func testGetMediaListUrlUseCaseWithoutErrors() async throws {
        self.initDependency()
        let result = try await self.usecase.execute().get()
        XCTAssert(result is Array<URL>)
    }
}
