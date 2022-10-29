//
//  LoginUseCaseTest.swift
//  Photo Gallery With Firebase SDKTests
//
//  Created by Paulo Antonelli on 29/10/22.
//

import XCTest
@testable import Photo_Gallery_With_Firebase_SDK

struct FirebaseMock: IFirebaseService {
    let user: User = User(id: "user123", username: "Paulo Antonelli", photoUrl: URL(string: "https://minhafoto.com/pauloantonelli")!)
    
    func login(email: String, password: String) async throws -> User {
        return self.user
    }
    
    func register(email: String, password: String) async throws -> User {
        return self.user
    }
}
class LoginUseCaseTest: XCTestCase {
    var firebaseService: IFirebaseService!
    var datasource: LoginDataSource!
    var repository: LoginRepository!
    var usecase: LoginUseCase!
    let email: Email = Email(email: "pauloantonelli@zoominitcode.dev")
    let password: Password = Password(password: "abc123")
    
    func initializeDependency() -> Void {
        self.firebaseService = FirebaseMock()
        self.datasource = LoginDataSource(firebase: self.firebaseService)
        self.repository = LoginRepository(datasource: datasource)
        self.usecase = LoginUseCase(repository: repository)
    }
    
    override func setUpWithError() throws {
        self.initializeDependency()
    }

    func testLoginWithoutErrors() async throws {
        let credential: Credential = Credential(email: self.email, password: self.password)
        let result = await self.usecase.execute(withCredential: credential)
        XCTAssert(try result.get() is User)
    }
    
    func testLoginWithEmailError() async throws {
        let credential: Credential = Credential(email: Email(), password: self.password)
        let result = await self.usecase.execute(withCredential: credential)
        XCTAssert(try result is LoginErrorUseCase)
    }
}
