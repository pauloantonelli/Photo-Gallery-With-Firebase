//
//  GetMediaUrlError.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 09/11/22.
//

import Foundation

protocol GetMediaUrlError: Error {
    var message: String { get }
}

public class GetMediaUrlErrorUseCase: GetMediaUrlError {
    let message: String
    init(message: String) {
        self.message = message
    }
}

class GetMediaUrlErrorDrive: GetMediaUrlErrorUseCase {
    override init(message: String) {
        super.init(message: message)
    }
}

class GetMediaUrlErrorService: GetMediaUrlErrorDrive {
    override init(message: String) {
        super.init(message: message)
    }
}
