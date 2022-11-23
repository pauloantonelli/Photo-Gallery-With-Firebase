//
//  ForgotPasswordError.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 23/11/22.
//

import Foundation

public protocol ForgotPasswordError: Error {
    var message: String { get }
}

public class ForgotPasswordErrorUseCase: ForgotPasswordError {
    public let message: String
    init(message: String) {
        self.message = message
    }
}

class ForgotPasswordErrorRepository: ForgotPasswordErrorUseCase {
    override init(message: String) {
        super.init(message: message)
    }
}

class ForgotPasswordErrorDataSource: ForgotPasswordErrorRepository {
    override init(message: String) {
        super.init(message: message)
    }
}
