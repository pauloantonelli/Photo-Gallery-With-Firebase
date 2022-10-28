//
//  Credential.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 26/10/22.
//

import Foundation

struct Credential {
    let email: Email
    let password: Password
    
    init(email: Email = Email(), password: Password = Password()) {
        self.email = email
        self.password = password
    }
}
