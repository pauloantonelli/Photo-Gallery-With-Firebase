//
//  DependencyInjection.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 28/10/22.
//

import Foundation

protocol IDependencyInjection {
    func register<Component>(type: Component.Type, component: Any) -> Void
    func resolve<Component>(_ type: Component.Type) -> Component?
}

final class DependencyInjection: IDependencyInjection {
    static let shared: DependencyInjection = DependencyInjection()
    
    private init() {}
    
    var componentList: [String: Any] = [:]
    
    func register<Component>(type: Component.Type, component: Any) -> Void {
        self.componentList["\(type)"] = componentList
    }
    
    func resolve<Component>(_ type: Component.Type) -> Component? {
        let result = self.componentList["\(type)"] as? Component
        return result
    }
}
