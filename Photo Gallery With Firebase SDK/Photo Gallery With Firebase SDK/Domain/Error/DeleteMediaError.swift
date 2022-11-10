//
//  DeleteMediaError.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 10/11/22.
//

import Foundation

protocol DeleteMediaError: Error {
    var message: String { get }
}

class DeleteMediaErrorUseCase: DeleteMediaError {
    let message: String
    init(message: String) {
        self.message = message
    }
}

class DeleteMediaErrorDrive: DeleteMediaErrorUseCase {
    override init(message: String) {
        super.init(message: message)
    }
}

class DeleteMediaErrorService: DeleteMediaErrorDrive {
    override init(message: String) {
        super.init(message: message)
    }
}
