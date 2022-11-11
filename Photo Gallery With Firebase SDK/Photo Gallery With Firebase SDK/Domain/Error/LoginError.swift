//
//  LoginError.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 27/10/22.
//

import Foundation

protocol LoginError: Error {
    var message: String { get }
}

public class LoginErrorUseCase: LoginError {
    let message: String
    init(message: String) {
        self.message = message
    }
}

class LoginErrorRepository: LoginErrorUseCase {
    override init(message: String) {
        super.init(message: message)
    }
}

class LoginErrorDataSource: LoginErrorRepository {
    override init(message: String) {
        super.init(message: message)
    }
}
