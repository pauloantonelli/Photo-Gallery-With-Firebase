//
//  DependencyInjection.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 28/10/22.
//

import Foundation

public final class DependencyInjection: IDependencyInjection {
    private init() {}
    
    static fileprivate var instanceList: [String: Any] = [:]
    
    public static func register<T>(type: T.Type, instance: Any) -> Void {
        self.instanceList["\(type)"] = instance
    }
    
    public static func get<T>(_ type: T.Type) -> T? {
        if self.instanceList["\(type)"] == nil {
            print(DependencyInjectionError(message: "Instance not found \(type)"))
        }
        let result = self.instanceList["\(type)"] as? T
        return result
    }
    
    public static func dispose<T>(_ type: T.Type) -> T? {
        guard let result = self.instanceList.removeValue(forKey: "\(type)") else {
            return nil
        }
        return result as? T
    }
}
