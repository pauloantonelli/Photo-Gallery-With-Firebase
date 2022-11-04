//
//  NetworkTest.swift
//  Photo Gallery With Firebase SDKTests
//
//  Created by Paulo Antonelli on 04/11/22.
//

import XCTest
@testable import Photo_Gallery_With_Firebase_SDK

class NetworkTest: XCTestCase {
    var network: INetwork!
    
    func initDependency() -> Void {
        self.network = Network(baseUrl: "https://jsonplaceholder.typicode.com")
    }
    
    func testGetMethod() async throws {
        self.initDependency()
        let result = await self.network.get(url: "/todos/1")
        XCTAssert(result.1.statusCode == 200)
    }
    
    func testPostMethod() async throws {
        self.initDependency()
        let body: [String:AnyHashable] = [
            "userId": 1,
            "title": "Hello World",
            "body": "Uchiha is Here!"
        ]
        let result = await self.network.post(url: "/posts", withBody: body)
        XCTAssert(result.1.statusCode == 201)
    }
    
    func testPutMethod() async throws {
        self.initDependency()
        let body: [String:AnyHashable] = [
            "id": 1,
            "title": "foo",
            "body": "bar",
            "userId": 1,
        ]
        let result = await self.network.put(url: "/posts/1", withBody: body)
        XCTAssert(result.1.statusCode == 200)
    }
    
    func testDeleteMethod() async throws {
        self.initDependency()
        let result = await self.network.delete(url: "/posts/1", withBody: nil)
        XCTAssert(result.1.statusCode == 200)
    }
}
