//
//  RegisterUseCaseTest.swift
//  Photo Gallery With Firebase SDKTests
//
//  Created by Paulo Antonelli on 31/10/22.
//

import XCTest
@testable import Photo_Gallery_With_Firebase_SDK

struct RegisterFirebaseMock: IFirebaseService {
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
class RegisterUseCaseTest: XCTestCase {
    var firebaseService: IFirebaseService!
    var datasource: RegisterDataSource!
    var repository: RegisterRepository!
    var usecase: RegisterUseCase!
    let email: Email = Email(email: "pauloantonelli@zoominitcode.dev")
    let password: Password = Password(password: "abc123")
    
    func initializeDependency(withMock mock: IFirebaseService) -> Void {
        self.firebaseService = mock
        self.datasource = RegisterDataSource(firebase: self.firebaseService)
        self.repository = RegisterRepository(datasource: datasource)
        self.usecase = RegisterUseCase(repository: repository)
    }
    
    func testRegisterWithoutErrors() async throws {
        let credential: Credential = Credential(email: self.email, password: self.password)
        self.initializeDependency(withMock: RegisterFirebaseMock())
        let result = try await self.usecase.execute(withCredential: credential).get()
        XCTAssert(result is User)
    }
    
    func testRegisterWithEmailError() async throws {
        let credential: Credential = Credential(email: Email(), password: self.password)
        self.initializeDependency(withMock: RegisterFirebaseMock())
        do {
            let _ = try await self.usecase.execute(withCredential: credential).get()
        } catch {
            XCTAssert(error is RegisterErrorUseCase)
        }
    }
    
    func testRegisterWithPasswordError() async throws {
        let credential: Credential = Credential(email: self.email, password: Password())
        self.initializeDependency(withMock: RegisterFirebaseMock())
        do {
            let _ = try await self.usecase.execute(withCredential: credential).get()
        } catch {
            XCTAssert(error is RegisterErrorUseCase)
        }
    }
}
