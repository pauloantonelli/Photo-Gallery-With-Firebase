//
//  CameraPermissionError.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 31/10/22.
//

import Foundation

public protocol CameraPermissionError: Error {
    var message: String { get }
}

public class CameraPermissionErrorUseCase: CameraPermissionError {
    public let message: String
    init(message: String) {
        self.message = message
    }
}

public class CameraPermissionErrorDrive: CameraPermissionErrorUseCase {
    override init(message: String) {
        super.init(message: message)
    }
}

public class CameraPermissionErrorService: CameraPermissionErrorDrive {
    override init(message: String) {
        super.init(message: message)
    }
}
