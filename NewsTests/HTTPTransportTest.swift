//
//  HTTPTransportTest.swift
//  NewsTests
//
//  Created by Paul Nadolynskyi on 8/22/19.
//  Copyright © 2019 paul. All rights reserved.
//

import XCTest

class HTTPTransportTest: XCTestCase {
    var transport: HTTPTransport!
    
    override func setUp() {
        super.setUp()
        
        transport = HTTPTransport()
    }
    
    override func tearDown() {
        transport = nil
        
        super.tearDown()
    }

    func testTransportCallback() {
        let promise = expectation(description: "Completion handler invoked")

        let sessionMock = URLSessionMock()
        let initialData = NSUUID().uuidString.data(using: .utf8)!
        sessionMock.data = initialData
        transport.session = sessionMock
        transport.run(url: URL(string: "localhost")!, method: .get) { (data, error) in
            XCTAssertEqual(initialData, data, "Data should be equal")
            promise.fulfill()
        }
        wait(for: [promise], timeout: 1)

    }
}
