//
//  RegisterDataSource.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 27/10/22.
//

import Foundation

public struct RegisterDataSource: IRegisterDataSource {
    let firebase: IFirebaseService
    
    public init(firebase: IFirebaseService) {
        self.firebase = firebase
    }
    
    public func execute(withCredential credential: Credential) async throws -> User {
        do {
            let result: User = try await self.firebase.register(email: credential.email.value, password: credential.password.value)
            return result
        } catch {
            throw RegisterErrorDataSource(message: "Error on Register \(error.localizedDescription)")
        }
    }
}
