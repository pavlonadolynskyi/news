//
//  JSONParserTest.swift
//  NewsTests
//
//  Created by Paul Nadolynskyi on 8/22/19.
//  Copyright © 2019 paul. All rights reserved.
//

import XCTest

class JSONParserTest: XCTestCase {
    var parser: JSONParser!
    
    override func setUp() {
        super.setUp()

        parser = JSONParser()
    }

    override func tearDown() {
        parser = nil
        
        super.tearDown()
    }
    
    func testParserCallback() {
        let promise = expectation(description: "Completion handler invoked")
        
        let json = ""
        let data = json.data(using: .utf8)!
        parser.parse(Post.self, data: data) { (object, error) in
            promise.fulfill()
        }
        wait(for: [promise], timeout: 1)
    }

    func testPost() {
        let json = "{\"userId\": 1, \"id\": 1, \"title\": \"sunt aut facere repellat provident occaecati excepturi optio reprehenderit\",\"body\": \"quia et suscipit\\nsuscipit recusandae consequuntur expedita et cum\\nreprehenderit molestiae ut ut quas totam\\nnostrum rerum est autem sunt rem eveniet architecto\"}"
        let data = json.data(using: .utf8)!
        
        parser.parse(Post.self, data: data) { (object, error) in
            XCTAssertNotNil(object, "Failed to parse with error: \(String(describing: error?.localizedDescription))")
        }
    }
    
    func testUser() {
        let json = "{\"id\": 1, \"name\": \"Peter Parker\"}"
        let data = json.data(using: .utf8)!
        
        parser.parse(User.self, data: data) { (object, error) in
            XCTAssertNotNil(object, "Failed to parse with error: \(String(describing: error?.localizedDescription))")
        }
    }
    
    func testComment() {
        let json = "{\"id\": 1, \"name\": \"Peter Parker\", \"body\": \"Good Post!\"}"
        let data = json.data(using: .utf8)!
        
        parser.parse(Comment.self, data: data) { (object, error) in
            XCTAssertNotNil(object, "Failed to parse with error: \(String(describing: error?.localizedDescription))")
        }
    }

}
