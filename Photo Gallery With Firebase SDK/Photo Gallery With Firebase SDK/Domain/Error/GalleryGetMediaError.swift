//
//  GalleryGetMedia.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 02/11/22.
//

import Foundation

protocol GalleryGetMediaError: Error {
    var message: String { get }
}

class GalleryGetMediaErrorUseCase: GalleryGetMediaError {
    let message: String
    init(message: String) {
        self.message = message
    }
}

class GalleryGetMediaErrorDrive: GalleryGetMediaErrorUseCase {
    override init(message: String) {
        super.init(message: message)
    }
}

class GalleryGetMediaErrorService: GalleryGetMediaErrorDrive {
    override init(message: String) {
        super.init(message: message)
    }
}
