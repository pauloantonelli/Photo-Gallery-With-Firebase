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
    var dependencyInjection: IDependencyInjection = DependencyInjection.shared
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        self.dependencyInjection.register(type: InjectStructExample1.self, component: InjectStructExample1())
        let result = self.dependencyInjection.resolve(InjectStructExample1.self)
        XCTAssertEqual(result, InjectStructExample1.self)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
