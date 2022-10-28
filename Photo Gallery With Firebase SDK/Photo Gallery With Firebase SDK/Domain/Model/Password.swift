//
//  Password.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 26/10/22.
//

import Foundation

struct Password {
    let value: String
    var isValid: Bool {
        get {
            if self.value.isEmpty {
                return false
            }
            return true
        }
    }
    
    init(password: String = "") {
        self.value = password
    }
}
