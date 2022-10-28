//
//  Email.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 26/10/22.
//

import Foundation

struct Email {
    let value: String
    var isValid: Bool {
        get {
            if self.value.isEmpty {
                return false
            }
            return true
        }
    }
    
    init(email: String = "") {
        self.value = email
    }
}
