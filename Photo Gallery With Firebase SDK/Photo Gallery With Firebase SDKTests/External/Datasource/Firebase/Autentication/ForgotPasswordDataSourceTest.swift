//
//  ForgotPasswordDataSourceTest.swift
//  Photo Gallery With Firebase SDKTests
//
//  Created by Paulo Antonelli on 23/11/22.
//

import XCTest
@testable import Photo_Gallery_With_Firebase_SDK

struct ForgotPasswordDataSourceFirebaseMock: IFirebaseService {
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
struct ForgotPasswordDataSourceFirebaseErrorMock: IFirebaseService {
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
        throw ForgotPasswordErrorDataSource(message: "Error")
    }
}
final class ForgotPasswordDataSourceTest: XCTestCase {
    var datasource: IForgotPasswordDataSource!
    var firebaseService: IFirebaseService!
    let email: Email = Email(email: "pauloantonelli@zoominitcode.dev")
    
    func initDependency(withMock mock: IFirebaseService) -> Void {
        self.firebaseService = mock
        self.datasource = ForgotPasswordDataSource(firebaseService: mock)
    }
    
    func testForgotPasswordDataSourceWithoutError() async throws {
        self.initDependency(withMock: ForgotPasswordDataSourceFirebaseMock())
        let result = try await self.datasource.execute(withEmail: self.email)
        XCTAssert(result == true)
    }
    
    func testForgotPasswordDataSourceWithError() async throws {
        self.initDependency(withMock: ForgotPasswordDataSourceFirebaseErrorMock())
        do {
            let _ = try await self.datasource.execute(withEmail: self.email)
        } catch {
            XCTAssert(error is ForgotPasswordErrorDataSource)
        }
    }
}
