//
//  APITransport.swift
//  News
//
//  Created by Paul Nadolynskyi on 8/21/19.
//  Copyright © 2019 paul. All rights reserved.
//

import Foundation

enum APIMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol APITransport {
    func run(url: URL, method: APIMethod, completion: @escaping (_ data: Data?, _ error: Error?) -> ())
}
