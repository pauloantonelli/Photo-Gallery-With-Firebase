//
//  IDependencyInjection.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 11/11/22.
//

import Foundation

public protocol IDependencyInjection {
    static func register<T>(type: T.Type, instance: Any) -> Void
    static func get<T>(_ type: T.Type) -> T?
}
