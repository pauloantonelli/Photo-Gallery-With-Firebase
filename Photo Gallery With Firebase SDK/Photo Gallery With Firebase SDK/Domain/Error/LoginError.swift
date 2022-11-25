//
//  LoginError.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 27/10/22.
//

import Foundation

public protocol LoginError: Error {
    var message: String { get }
}

public class LoginErrorUseCase: LoginError {
    public let message: String
    init(message: String) {
        self.message = message
    }
}

public class LoginErrorRepository: LoginErrorUseCase {
    override init(message: String) {
        super.init(message: message)
    }
}

public class LoginErrorDataSource: LoginErrorRepository {
    override init(message: String) {
        super.init(message: message)
    }
}
