//
//  Cache.swift
//  News
//
//  Created by Paul Nadolynskyi on 8/21/19.
//  Copyright © 2019 paul. All rights reserved.
//

import Foundation

protocol Cache {
    func save(data: Data, key: String)
    func load(key: String) -> Data?
    func clear()
}
