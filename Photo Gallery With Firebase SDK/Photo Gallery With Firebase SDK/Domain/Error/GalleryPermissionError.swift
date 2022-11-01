//
//  GalleryPermissionError.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 31/10/22.
//

import Foundation

protocol GalleryPermissionError: Error {
    var message: String { get }
}

class GalleryPermissionErrorUseCase: GalleryPermissionError {
    let message: String
    init(message: String) {
        self.message = message
    }
}

class GalleryPermissionErrorDrive: GalleryPermissionErrorUseCase {
    override init(message: String) {
        super.init(message: message)
    }
}

class GalleryPermissionErrorService: GalleryPermissionErrorDrive {
    override init(message: String) {
        super.init(message: message)
    }
}
