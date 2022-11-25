//
//  RegisterError.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 27/10/22.
//

import Foundation

public protocol RegisterError: Error {
    var message: String { get }
}

public class RegisterErrorUseCase: RegisterError {
    public let message: String
    init(message: String) {
        self.message = message
    }
}

public class RegisterErrorRepository: RegisterErrorUseCase {
    override init(message: String) {
        super.init(message: message)
    }
}

public class RegisterErrorDataSource: RegisterErrorRepository {
    override init(message: String) {
        super.init(message: message)
    }
}
