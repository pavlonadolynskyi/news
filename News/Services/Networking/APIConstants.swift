//
//  APIConstants.swift
//  News
//
//  Created by Paul Nadolynskyi on 8/21/19.
//  Copyright © 2019 paul. All rights reserved.
//

import Foundation

struct APIPath {
    private static let baseURL = "http://jsonplaceholder.typicode.com"
    
    struct posts: APIPathGenerator {
        static let resource = "posts"
    }
    
    struct users: APIPathGenerator {
        static let resource = "users"
    }
    
    struct comments: APIPathGenerator {
        static let resource = "comments"
        static func forPost(id: Int) -> String {
            return "\(resource)?postId=\(id)"
        }
    }
    
    static func fullPath(_ path: String) -> String {
        return "\(baseURL)/\(path)"
    }
}

protocol APIPathGenerator {
    static var resource: String { get }
    static func one(id: Int) -> String
    static func all() -> String
}

extension APIPathGenerator {
    static func one(id: Int) -> String {
        return "\(resource)/\(id)"
    }
    
    static func all() -> String {
        return resource
    }
}
