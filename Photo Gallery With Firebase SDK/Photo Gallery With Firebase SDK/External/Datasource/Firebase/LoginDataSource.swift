//
//  LoginDataSource.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 27/10/22.
//

import Foundation

struct LoginDataSource: ILoginDataSource {
    let firebase: FirebaseService
    
    init(firebase: FirebaseService) {
        self.firebase = firebase
    }
    
    func execute(withCredential credential: Credential) async throws -> User {
        self.firebase.login(email: credential.email.value, password: credential.password.value)
    }
}
