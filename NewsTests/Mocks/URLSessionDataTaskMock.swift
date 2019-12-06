//
//  URLSessionDataTaskMock.swift
//  NewsTests
//
//  Created by Paul Nadolynskyi on 8/22/19.
//  Copyright © 2019 paul. All rights reserved.
//

import Foundation

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}
