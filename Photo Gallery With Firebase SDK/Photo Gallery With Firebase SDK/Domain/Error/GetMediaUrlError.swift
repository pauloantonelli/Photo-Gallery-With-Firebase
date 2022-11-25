//
//  GetMediaUrlError.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 09/11/22.
//

import Foundation

public protocol GetMediaUrlError: Error {
    var message: String { get }
}

public class GetMediaUrlErrorUseCase: GetMediaUrlError {
    public let message: String
    init(message: String) {
        self.message = message
    }
}

public class GetMediaUrlErrorDrive: GetMediaUrlErrorUseCase {
    override init(message: String) {
        super.init(message: message)
    }
}

public class GetMediaUrlErrorService: GetMediaUrlErrorDrive {
    override init(message: String) {
        super.init(message: message)
    }
}
