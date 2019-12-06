//
//  HTTPTransport.swift
//  News
//
//  Created by Paul Nadolynskyi on 8/21/19.
//  Copyright © 2019 paul. All rights reserved.
//

import Foundation

class HTTPTransport: APITransport {
    var session = URLSession.shared
    
    func run(url: URL, method: APIMethod, completion: @escaping (Data?, Error?) -> ()) {
        var request = URLRequest(url: url)
        request.httpMethod = APIMethod.get.rawValue
        session.dataTask(with: request) { (data, URLResponse, error) in
            completion(data, error)
        }.resume()
    }
}
