//
//  RegisterDataSourceTest.swift
//  Photo Gallery With Firebase SDKTests
//
//  Created by Paulo Antonelli on 31/10/22.
//

import XCTest
@testable import Photo_Gallery_With_Firebase_SDK

struct RegisterFirebaseErrorMock: IFirebaseService {
    let user: User = User(id: "user123", username: "Paulo Antonelli", photoUrl: URL(string: "https://minhafoto.com/pauloantonelli")!)
    
    func login(email: String, password: String) async throws -> User {
        throw RegisterErrorDataSource(message: "Error on login")
    }
    
    func register(email: String, password: String) async throws -> User {
        throw RegisterErrorDataSource(message: "Error on register")
    }
    
    func signOut() throws -> Bool {
        false
    }
    
    func forgotPassword(withEmail email: String) async throws -> Bool {
        false
    }
}
class RegisterDataSourceTest: XCTestCase {
    var firebaseService: IFirebaseService!
    var datasource: RegisterDataSource!
    let email: Email = Email(email: "pauloantonelli@zoominitcode.dev")
    let password: Password = Password(password: "abc123")
    
    func initializeDependency(withMock mock: IFirebaseService) -> Void {
        self.firebaseService = mock
        self.datasource = RegisterDataSource(firebase: self.firebaseService)
    }
    
    func testRegisterWithoutErrors() async throws {
        let credential: Credential = Credential(email: self.email, password: self.password)
        self.initializeDependency(withMock: RegisterFirebaseMock())
        let result = try await self.datasource.execute(withCredential: credential)
        XCTAssert(result is User)
    }
    
    func testRegisterWithEmailError() async throws {
        let credential: Credential = Credential(email: Email(), password: self.password)
        self.initializeDependency(withMock: RegisterFirebaseErrorMock())
        do {
        let _ = try await self.datasource.execute(withCredential: credential)
        } catch {
            XCTAssert(error is RegisterErrorDataSource)
        }
    }
}
