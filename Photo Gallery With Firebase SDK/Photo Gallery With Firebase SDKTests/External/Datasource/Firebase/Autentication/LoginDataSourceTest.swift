//
//  LoginDataSourceTest.swift
//  Photo Gallery With Firebase SDKTests
//
//  Created by Paulo Antonelli on 31/10/22.
//

import XCTest
@testable import Photo_Gallery_With_Firebase_SDK

struct LoginFirebaseErrorMock: IFirebaseService {
    let user: User = User(id: "user123", username: "Paulo Antonelli", photoUrl: URL(string: "https://minhafoto.com/pauloantonelli")!)
    
    func login(email: String, password: String) async throws -> User {
        throw LoginErrorDataSource(message: "Error on login")
    }
    
    func register(email: String, password: String) async throws -> User {
        throw LoginErrorDataSource(message: "Error on register")
    }
}
class LoginDataSourceTest: XCTestCase {
    var firebaseService: IFirebaseService!
    var datasource: LoginDataSource!
    let email: Email = Email(email: "pauloantonelli@zoominitcode.dev")
    let password: Password = Password(password: "abc123")
    
    func initializeDependency(withMock mock: IFirebaseService) -> Void {
        self.firebaseService = mock
        self.datasource = LoginDataSource(firebase: self.firebaseService)
    }
    
    func testLoginWithoutErrors() async throws {
        let credential: Credential = Credential(email: self.email, password: self.password)
        self.initializeDependency(withMock: LoginFirebaseMock())
        let result = try await self.datasource.execute(withCredential: credential)
        XCTAssert(result is User)
    }
    
    func testLoginWithEmailError() async throws {
        let credential: Credential = Credential(email: Email(), password: self.password)
        self.initializeDependency(withMock: LoginFirebaseErrorMock())
        do {
        let _ = try await self.datasource.execute(withCredential: credential)
        } catch {
            XCTAssert(error is LoginErrorDataSource)
        }
    }
}
