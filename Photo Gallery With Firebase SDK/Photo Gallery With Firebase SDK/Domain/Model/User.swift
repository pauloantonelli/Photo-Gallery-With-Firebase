//
//  User.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 26/10/22.
//

import Foundation

struct User {
    let id: String
    let username: String
    let photoUrl: URL
    let credential: Credential
    
    init(id: String, username: String = "", photoUrl: URL = URL(string: "")!, credential: Credential = Credential()) {
        self.id = id
        self.username = username
        self.photoUrl = photoUrl
        self.credential = credential
    }
}
