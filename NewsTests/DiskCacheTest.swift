//
//  DiskCacheTest.swift
//  NewsTests
//
//  Created by Paul Nadolynskyi on 8/22/19.
//  Copyright © 2019 paul. All rights reserved.
//

import XCTest

class DiskCacheTest: XCTestCase {
    var cache: DiskCache!
    
    override func setUp() {
        super.setUp()
        
        cache = DiskCache()
    }
    
    override func tearDown() {
        cache.clear()
        cache = nil
        
        super.tearDown()
    }

    func testMissingCache() {
        let key = NSUUID().uuidString
        let missingData = cache.load(key: key)
        XCTAssertNil(missingData, "Data must be nil if it was not set")
    }
    
    func testCacheSavingLoading() {
        let key = NSUUID().uuidString
        let data = NSUUID().uuidString.data(using: .utf8)!
        cache.save(data: data, key: key)
        let loadedData = cache.load(key: key)
        XCTAssertNotNil(loadedData, "Data must be loaded")
        XCTAssertEqual(data, loadedData, "Saved and restored data must be equal")
    }
}
