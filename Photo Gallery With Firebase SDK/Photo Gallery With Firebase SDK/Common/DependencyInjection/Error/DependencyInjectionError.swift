//
//  DependencyInjectionError.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 11/11/22.
//

import Foundation

struct DependencyInjectionError: Error {
    let message: String
    init(message: String) {
        self.message = message
    }
}
