//
//  DataProvider.swift
//  News
//
//  Created by Paul Nadolynskyi on 8/21/19.
//  Copyright © 2019 paul. All rights reserved.
//

import Foundation

typealias ParsedObjectCompletionHandler<T> = (T?, _ error: Error?) -> ()

class DataProvider {
    let transport: APITransport
    let parser: Parser
    let cache: Cache
    
    init(transport: APITransport, parser: Parser, cache: Cache) {
        self.transport = transport
        self.parser = parser
        self.cache = cache
    }
    
    func fetchPosts(completion: @escaping ParsedObjectCompletionHandler<[Post]>) {
        let path = APIPath.posts.all()
        let url = URL(string: APIPath.fullPath(path))!
        transport.run(url: url, method: .get) { (remoteData, error) in
            self.finishFetchRequest(relativePath: path, remoteData: remoteData, error: error, completion: { (object, error) in
                DispatchQueue.main.async {
                    completion(object, error)
                }
            })
        }
    }
    
    func fetchPostInfo(postId: Int, userId: Int, completion: @escaping (
        _ user: User?, _ userFetchError: Error?,
        _ comments: [Comment]?, _ commentsFetchError: Error?) -> ()) {
        
        var user: User? = nil
        var userFetchError: Error? = nil
        var comments: [Comment]? = nil
        var commentsFetchError: Error? = nil
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        fetchUser(id: userId) { (object, error) in
            user = object
            userFetchError = error
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        fetchComments(for: postId) { (objects, error) in
            comments = objects
            commentsFetchError = error
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) {
            completion(user, userFetchError, comments, commentsFetchError)
        }
    }
    
    func fetchUser(id: Int, completion: @escaping ParsedObjectCompletionHandler<User>) {
        let path = APIPath.users.one(id: id)
        let url = URL(string: APIPath.fullPath(path))!
        transport.run(url: url, method: .get) { (remoteData, error) in
            self.finishFetchRequest(relativePath: path, remoteData: remoteData, error: error, completion: { (object, error) in
                DispatchQueue.main.async {
                    completion(object, error)
                }
            })
        }
    }
    
    func fetchComments(for postId: Int, completion: @escaping ParsedObjectCompletionHandler<[Comment]>) {
        let path = APIPath.comments.forPost(id: postId)
        let url = URL(string: APIPath.fullPath(path))!
        transport.run(url: url, method: .get) { (remoteData, error) in
            self.finishFetchRequest(relativePath: path, remoteData: remoteData, error: error, completion: { (object, error) in
                DispatchQueue.main.async {
                    completion(object, error)
                }
            })
        }
    }
}

private extension DataProvider {
    func finishFetchRequest<T: Codable>(relativePath: String, remoteData: Data?, error: Error?, completion: @escaping ParsedObjectCompletionHandler<T>) {
        if let remoteData = remoteData {
            self.parser.parse(T.self, data: remoteData, completion: { (parsed, error) in
                if let parsed = parsed {
                    self.cache.save(data: remoteData, key: relativePath)
                    completion(parsed, error)
                } else if let cachedData = self.cache.load(key: relativePath) {
                    self.parser.parse(T.self, data: cachedData, completion: { (parsed, error) in
                        completion(parsed, error)
                    })
                } else {
                    completion(nil, error)
                }
            })
        } else if let cachedData = cache.load(key: relativePath) {
            self.parser.parse(T.self, data: cachedData, completion: { (parsed, error) in
                completion(parsed, error)
            })
        } else {
            completion(nil, error)
        }
    }
}
