//
//  RegisterError.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 27/10/22.
//

import Foundation

protocol RegisterError: Error {
    var message: String { get }
}

class RegisterErrorUseCase: RegisterError {
    let message: String
    init(message: String) {
        self.message = message
    }
}

class RegisterErrorRepository: RegisterErrorUseCase {
    override init(message: String) {
        super.init(message: message)
    }
}

class RegisterErrorDataSource: RegisterErrorRepository {
    override init(message: String) {
        super.init(message: message)
    }
}
