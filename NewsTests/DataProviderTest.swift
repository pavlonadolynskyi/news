//
//  DataProviderTest.swift
//  NewsTests
//
//  Created by Paul Nadolynskyi on 8/22/19.
//  Copyright © 2019 paul. All rights reserved.
//

import XCTest

class DataProviderTest: XCTestCase {
    var transport: HTTPTransport!
    var dataProvider: DataProvider!

    override func setUp() {
        super.setUp()
        
        transport = HTTPTransport()
        dataProvider = DataProvider(transport: transport, parser: JSONParser(), cache: DiskCache())
        dataProvider.cache.clear()
    }
    
    override func tearDown() {
        dataProvider.cache.clear()
        transport = nil
        dataProvider = nil
        super.tearDown()
    }
    
    func testPositiveFlow() {
        let promise = expectation(description: "Completion handler invoked")
        
        let json = "[{\"userId\": 1, \"id\": 1, \"title\": \"title\",\"body\": \"body\"}]"
        let responseData = json.data(using: .utf8)!
        
        let sessionMock = URLSessionMock()
        sessionMock.data = responseData
        transport.session = sessionMock
        
        dataProvider.fetchPosts { (posts, error) in
            XCTAssertEqual(posts?.count, 1, "1 object should be received")
            XCTAssertNil(error, "Should have no error")
            promise.fulfill()
        }
        wait(for: [promise], timeout: 1)
    }
    
    func testCachingFlow() {
        dataProvider.cache.clear()

        let promise = expectation(description: "Completion handler invoked")
        
        let json = "[{\"userId\": 1, \"id\": 1, \"title\": \"title\",\"body\": \"body\"}]"
        let responseData = json.data(using: .utf8)!

        let sessionMock = URLSessionMock()
        sessionMock.data = responseData
        transport.session = sessionMock
        
        dataProvider.fetchPosts { (posts, error) in
            XCTAssertEqual(posts?.count, 1, "1 object should be received")
            XCTAssertNil(error, "Should have no error")
            
            let sessionMock = URLSessionMock()
            sessionMock.error = NSError(domain: "App", code: -1, userInfo: nil)
            self.transport.session = sessionMock
            self.dataProvider.fetchPosts { (cachedPosts, cachedError) in
                XCTAssertEqual(posts?.count, 1, "1 object should be received from cache")
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 1)
    }
    
    func testNegativeFlow() {
        dataProvider.cache.clear()

        let promise = expectation(description: "Completion handler invoked")
        
        let sessionMock = URLSessionMock()
        sessionMock.data = nil
        sessionMock.error = NSError(domain: "App", code: -1, userInfo: nil)
        transport.session = sessionMock
        dataProvider.fetchPosts { (posts, error) in
            XCTAssertNil(posts, "Should have no posts received")
            XCTAssertNotNil(error, "Should have error received")
            promise.fulfill()
        }
        wait(for: [promise], timeout: 1)
    }
}
