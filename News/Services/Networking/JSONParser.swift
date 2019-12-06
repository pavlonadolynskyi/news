//
//  JSONParser.swift
//  News
//
//  Created by Paul Nadolynskyi on 8/21/19.
//  Copyright © 2019 paul. All rights reserved.
//

import Foundation

class JSONParser: Parser {
    let decoder = JSONDecoder()
    func parse<T>(_ type: T.Type, data: Data, completion: @escaping (T?, Error?) -> ()) where T : Decodable {
        do {
            let parsed = try decoder.decode(T.self, from: data)
            completion(parsed, nil)
        } catch {
            completion(nil, error)
        }
    }
}
