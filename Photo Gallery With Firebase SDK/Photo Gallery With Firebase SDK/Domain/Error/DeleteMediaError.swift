//
//  DeleteMediaError.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 10/11/22.
//

import Foundation

public protocol DeleteMediaError: Error {
    var message: String { get }
}

public class DeleteMediaErrorUseCase: DeleteMediaError {
    public let message: String
    init(message: String) {
        self.message = message
    }
}

public class DeleteMediaErrorDrive: DeleteMediaErrorUseCase {
    override init(message: String) {
        super.init(message: message)
    }
}

public class DeleteMediaErrorService: DeleteMediaErrorDrive {
    override init(message: String) {
        super.init(message: message)
    }
}
