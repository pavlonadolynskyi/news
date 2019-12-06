//
//  URLSessionMock.swift
//  NewsTests
//
//  Created by Paul Nadolynskyi on 8/22/19.
//  Copyright © 2019 paul. All rights reserved.
//

import Foundation

class URLSessionMock: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

    var data: Data?
    var error: Error?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return URLSessionDataTaskMock {
            completionHandler(self.data, nil, self.error)
        }
    }
}
