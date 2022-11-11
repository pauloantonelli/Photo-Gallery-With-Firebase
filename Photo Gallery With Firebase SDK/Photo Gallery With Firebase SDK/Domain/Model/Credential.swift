//
//  Credential.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 26/10/22.
//

import Foundation

public struct Credential {
    let email: Email
    let password: Password
    
    public init(email: Email = Email(), password: Password = Password()) {
        self.email = email
        self.password = password
    }
}
