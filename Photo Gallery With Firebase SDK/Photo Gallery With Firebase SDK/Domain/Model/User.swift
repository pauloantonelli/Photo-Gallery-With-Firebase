//
//  User.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 26/10/22.
//

import Foundation

public struct User {
    public let id: String
    public let username: String
    public let photoUrl: URL
    public let credential: Credential
    public var isLogged: Bool {
        if self.id.count == 0 {
            return false
        }
        return true
    }
    
    public init(id: String, username: String = "", photoUrl: URL = URL(string: AppConstant.image)!, credential: Credential = Credential()) {
        self.id = id
        self.username = username
        self.photoUrl = photoUrl
        self.credential = credential
    }
}
