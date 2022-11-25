//
//  GalleryPermissionError.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 31/10/22.
//

import Foundation

public protocol GalleryPermissionError: Error {
    var message: String { get }
}

public class GalleryPermissionErrorUseCase: GalleryPermissionError {
    public let message: String
    init(message: String) {
        self.message = message
    }
}

public class GalleryPermissionErrorDrive: GalleryPermissionErrorUseCase {
    override init(message: String) {
        super.init(message: message)
    }
}

public class GalleryPermissionErrorService: GalleryPermissionErrorDrive {
    override init(message: String) {
        super.init(message: message)
    }
}
