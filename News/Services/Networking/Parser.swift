//
//  Parser.swift
//  News
//
//  Created by Paul Nadolynskyi on 8/21/19.
//  Copyright © 2019 paul. All rights reserved.
//

import Foundation

protocol Parser {
    func parse<T>(_ type: T.Type, data: Data, completion: @escaping (_ parsed: T?, _ error: Error?) -> ()) where T: Decodable
}


