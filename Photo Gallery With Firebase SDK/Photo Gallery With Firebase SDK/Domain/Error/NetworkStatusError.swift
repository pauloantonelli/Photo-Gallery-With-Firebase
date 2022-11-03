//
//  NetworkStatusError.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 02/11/22.
//

import Foundation

protocol NetworkStatusError: Error {
    var message: String { get }
}

class NetworkStatusErrorUseCase: NetworkStatusError {
    let message: String
    init(message: String) {
        self.message = message
    }
}

class NetworkStatusErrorDrive: NetworkStatusErrorUseCase {
    override init(message: String) {
        super.init(message: message)
    }
}

class NetworkStatusErrorService: NetworkStatusErrorDrive {
    override init(message: String) {
        super.init(message: message)
    }
}
