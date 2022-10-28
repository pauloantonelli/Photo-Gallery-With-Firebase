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
    var isInvalid: Bool {
        return !self.isValid
    }
    
    init(email: String = "") {
        self.value = email
    }
}
