//
//  CameraGetMediaError.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 02/11/22.
//

import Foundation

protocol CameraGetMediaError: Error {
    var message: String { get }
}

class CameraGetMediaErrorUseCase: CameraGetMediaError {
    let message: String
    init(message: String) {
        self.message = message
    }
}

class CameraGetMediaErrorDrive: CameraGetMediaErrorUseCase {
    override init(message: String) {
        super.init(message: message)
    }
}

class CameraGetMediaErrorService: CameraGetMediaErrorDrive {
    override init(message: String) {
        super.init(message: message)
    }
}
