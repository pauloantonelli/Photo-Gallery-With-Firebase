//
//  NetworkStatusError.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 02/11/22.
//

import Foundation

public protocol NetworkStatusError: Error {
    var message: String { get }
}

public class NetworkStatusErrorUseCase: NetworkStatusError {
    public let message: String
    init(message: String) {
        self.message = message
    }
}

public class NetworkStatusErrorDrive: NetworkStatusErrorUseCase {
    override init(message: String) {
        super.init(message: message)
    }
}

public class NetworkStatusErrorService: NetworkStatusErrorDrive {
    override init(message: String) {
        super.init(message: message)
    }
}
