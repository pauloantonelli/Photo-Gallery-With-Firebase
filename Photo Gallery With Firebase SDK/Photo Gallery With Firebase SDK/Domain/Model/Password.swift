//
//  Password.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 26/10/22.
//

import Foundation

public struct Password {
    let value: String
    public var isValid: Bool {
        get {
            if self.value.isEmpty {
                return false
            }
            return validate(password: self.value)
        }
    }
    public var isInvalid: Bool {
        return !self.isValid
    }
    
    public init(password: String = "") {
        self.value = password
    }
}
extension Password {
    func validate(password: String) -> Bool {
        // MARK: primeira condicional posta para facilitar. Em prod seria somente o password pattern
        if password.count >= 6 {
            return true
        }
        let passwordPattern: String =
            // At least 6 characters
            #"(?=.{6,})"# +
            // At least one capital letter
            #"(?=.*[A-Z])"# +
            // At least one lowercase letter
            #"(?=.*[a-z])"# +
            // At least one digit
            #"(?=.*\d)"# +
            // At least one special character
            #"(?=.*[ !$%&?._-])"#
        let result = password.range(of: passwordPattern, options: .regularExpression)
        let validPassword = result != nil
        return validPassword
    }
}
