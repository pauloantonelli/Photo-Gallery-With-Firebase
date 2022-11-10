//
//  GetMediaListError.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 10/11/22.
//

import Foundation

protocol GetMediaListUrlError: Error {
    var message: String { get }
}

class GetMediaListUrlErrorUseCase: GetMediaListUrlError {
    let message: String
    init(message: String) {
        self.message = message
    }
}

class GetMediaListUrlErrorDrive: GetMediaListUrlErrorUseCase {
    override init(message: String) {
        super.init(message: message)
    }
}

class GetMediaListUrlErrorService: GetMediaListUrlErrorDrive {
    override init(message: String) {
        super.init(message: message)
    }
}
