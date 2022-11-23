//
//  LoginDataSource.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 27/10/22.
//

import Foundation

public struct LoginDataSource: ILoginDataSource {
    let firebase: IFirebaseService
    
    public init(firebase: IFirebaseService) {
        self.firebase = firebase
    }
    
    public func execute(withCredential credential: Credential) async throws -> User {
        do {
            let result = try await self.firebase.login(email: credential.email.value, password: credential.password.value)
            return result
        } catch {
            throw LoginErrorDataSource(message: "Error on login \(error.localizedDescription)")
        }
    }
}
