//
//  DependencyInjectionTest.swift
//  Photo Gallery With Firebase SDKTests
//
//  Created by Paulo Antonelli on 28/10/22.
//

import XCTest
@testable import Photo_Gallery_With_Firebase_SDK

struct InjectStructExample1 {   }
struct InjectStructExample2 {   }

class DependencyInjectionTest: XCTestCase {
    
    func testGetExistentInstance() throws {
        DependencyInjection.register(type: InjectStructExample1.self, instance: InjectStructExample1())
        let result = DependencyInjection.get(InjectStructExample1.self)
        XCTAssertEqual((result != nil), true)
    }
    
    func testGetExactExistentInstanceSignature() throws {
        DependencyInjection.register(type: InjectStructExample1.self, instance: InjectStructExample1())
        let result = DependencyInjection.get(InjectStructExample1.self)
        XCTAssertTrue(result! is InjectStructExample1)
    }
    
    func testGetNotExistentInstance() throws {
        DependencyInjection.register(type: InjectStructExample1.self, instance: InjectStructExample1())
        let result = DependencyInjection.get(InjectStructExample2.self)
        XCTAssertEqual((result == nil), true)
    }
    
    func testDisposeInstance() throws {
        DependencyInjection.register(type: InjectStructExample1.self, instance: InjectStructExample1())
        let getResult = DependencyInjection.get(InjectStructExample1.self)
        XCTAssertTrue(getResult! is InjectStructExample1)
        let result = DependencyInjection.dispose(InjectStructExample1.self)
        XCTAssertTrue(result! is InjectStructExample1)
    }
    
    func testDisposeInstanceWithInexistentInstance() throws {
        DependencyInjection.register(type: InjectStructExample1.self, instance: InjectStructExample1())
        let getResult = DependencyInjection.get(InjectStructExample1.self)
        XCTAssertTrue(getResult! is InjectStructExample1)
        let result = DependencyInjection.dispose(InjectStructExample2.self)
        XCTAssertTrue(result == nil)
    }
}
