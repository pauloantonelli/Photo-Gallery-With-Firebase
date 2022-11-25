//
//  GetMediaListError.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 10/11/22.
//

import Foundation

public protocol GetMediaListUrlError: Error {
    var message: String { get }
}

public class GetMediaListUrlErrorUseCase: GetMediaListUrlError {
    public let message: String
    init(message: String) {
        self.message = message
    }
}

public class GetMediaListUrlErrorDrive: GetMediaListUrlErrorUseCase {
    override init(message: String) {
        super.init(message: message)
    }
}

public class GetMediaListUrlErrorService: GetMediaListUrlErrorDrive {
    override init(message: String) {
        super.init(message: message)
    }
}
