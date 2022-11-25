//
//  SaveMedia.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 08/11/22.
//

import Foundation

public protocol SaveMediaError: Error {
    var message: String { get }
}

public class SaveMediaErrorUseCase: SaveMediaError {
    public let message: String
    init(message: String) {
        self.message = message
    }
}

public class SaveMediaErrorDrive: SaveMediaErrorUseCase {
    override init(message: String) {
        super.init(message: message)
    }
}

public class SaveMediaErrorService: SaveMediaErrorDrive {
    override init(message: String) {
        super.init(message: message)
    }
}
