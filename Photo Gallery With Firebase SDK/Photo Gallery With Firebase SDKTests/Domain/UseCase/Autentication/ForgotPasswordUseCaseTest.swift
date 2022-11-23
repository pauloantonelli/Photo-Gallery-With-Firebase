//
//  ForgotPasswordUseCaseTest.swift
//  Photo Gallery With Firebase SDKTests
//
//  Created by Paulo Antonelli on 23/11/22.
//

import XCTest
@testable import Photo_Gallery_With_Firebase_SDK

struct ForgotPasswordUseCaseFirebaseMock: IFirebaseService {
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
        true
    }
}
final class ForgotPasswordUseCaseTest: XCTestCase {
    var usecase: IForgotPasswordUseCase!
    var repository: IForgotPasswordRepository!
    var datasource: IForgotPasswordDataSource!
    var firebaseService: IFirebaseService!
    let email: Email = Email(email: "pauloantonelli@zoominitcode.dev")
    
    func initDependency(withMock mock: IFirebaseService) -> Void {
        self.firebaseService = mock
        self.datasource = ForgotPasswordDataSource(firebaseService: mock)
        self.repository =
        ForgotPasswordRepository(datasource: self.datasource)
        self.usecase = ForgotPasswordUseCase(repository: self.repository)
    }
    
    func testForgotPasswordUseCaseWithoutError() async throws {
        self.initDependency(withMock: ForgotPasswordUseCaseFirebaseMock())
        let result = try await self.usecase.execute(withEmail: email).get()
        XCTAssert(result == true)
    }
    
    func testForgotPasswordUseCaseWithEmailError() async throws {
        let email: Email = Email()
        self.initDependency(withMock: RegisterFirebaseMock())
        do {
            let _ = try await self.usecase.execute(withEmail: email).get()
        } catch {
            XCTAssert(error is ForgotPasswordErrorUseCase)
        }
    }
}
