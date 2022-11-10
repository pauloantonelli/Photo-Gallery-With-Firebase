//
//  GetMediaListError.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 10/11/22.
//

import Foundation

protocol GetMediaListError: Error {
    var message: String { get }
}

class GetMediaListErrorUseCase: GetMediaListError {
    let message: String
    init(message: String) {
        self.message = message
    }
}

class GetMediaListErrorDrive: GetMediaListErrorUseCase {
    override init(message: String) {
        super.init(message: message)
    }
}

class GetMediaListErrorService: GetMediaListErrorDrive {
    override init(message: String) {
        super.init(message: message)
    }
}
