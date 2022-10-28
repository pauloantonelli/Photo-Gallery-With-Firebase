//
//  RegisterDataSource.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 27/10/22.
//

import Foundation

struct RegisterDataSource: IRegisterDataSource {
    let firebase: IFirebaseService
    
    init(firebase: IFirebaseService) {
        self.firebase = firebase
    }
    
    func execute(withCredential credential: Credential) async throws -> User {
        do {
            let result = try await self.firebase.register(email: credential.email.value, password: credential.password.value)
            return result
        } catch {
            throw RegisterErrorDataSource(message: "Error on Register \(error.localizedDescription)")
        }
    }
}
