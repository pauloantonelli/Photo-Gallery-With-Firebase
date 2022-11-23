//
//  LoginUseCaseTest.swift
//  Photo Gallery With Firebase SDKTests
//
//  Created by Paulo Antonelli on 29/10/22.
//

import XCTest
@testable import Photo_Gallery_With_Firebase_SDK

struct LoginFirebaseMock: IFirebaseService {
    let user: User = User(id: "user123", username: "Paulo Antonelli", photoUrl: URL(string: "https://minhafoto.com/pauloantonelli")!)
    
    func login(email: String, password: String) async throws -> User {
        return self.user
    }
    
    func register(email: String, password: String) async throws -> User {
        return self.user
    }
    
    func signOut() throws -> Bool {
        false
    }
    
    func forgotPassword(withEmail email: String) async throws -> Bool {
        false
    }
}
class LoginUseCaseTest: XCTestCase {
    var firebaseService: IFirebaseService!
    var datasource: LoginDataSource!
    var repository: LoginRepository!
    var usecase: LoginUseCase!
    let email: Email = Email(email: "pauloantonelli@zoominitcode.dev")
    let password: Password = Password(password: "abc123")
    
    func initDependency(withMock mock: IFirebaseService) -> Void {
        self.firebaseService = mock
        self.datasource = LoginDataSource(firebase: self.firebaseService)
        self.repository = LoginRepository(datasource: datasource)
        self.usecase = LoginUseCase(repository: repository)
    }
    
    func testLoginWithoutErrors() async throws {
        let credential: Credential = Credential(email: self.email, password: self.password)
        self.initDependency(withMock: LoginFirebaseMock())
        let result = try await self.usecase.execute(withCredential: credential).get()
        XCTAssert(result is User)
    }
    
    func testLoginWithEmailError() async throws {
        let credential: Credential = Credential(email: Email(), password: self.password)
        self.initDependency(withMock: LoginFirebaseMock())
        do {
        let _ = try await self.usecase.execute(withCredential: credential).get()
        } catch {
            XCTAssert(error is LoginErrorUseCase)
        }
    }
    
    func testLoginWithPasswordError() async throws {
        let credential: Credential = Credential(email: self.email, password: Password())
        self.initDependency(withMock: LoginFirebaseMock())
        do {
        let _ = try await self.usecase.execute(withCredential: credential).get()
        } catch {
            XCTAssert(error is LoginErrorUseCase)
        }
    }
}
