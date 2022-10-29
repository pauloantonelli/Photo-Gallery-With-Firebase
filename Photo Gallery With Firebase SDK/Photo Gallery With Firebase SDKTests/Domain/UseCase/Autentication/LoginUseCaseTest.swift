//
//  LoginUseCaseTest.swift
//  Photo Gallery With Firebase SDKTests
//
//  Created by Paulo Antonelli on 29/10/22.
//

import XCTest
@testable import Photo_Gallery_With_Firebase_SDK

class LoginUseCaseTest: XCTestCase {
    var repository: LoginRepository
    var usecase: LoginUseCase
    
    override init() {
        super.init()
        self.repository = LoginRepository(datasource: )
        self.usecase = LoginUseCase(repository: repository)
    }
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
    }
}
