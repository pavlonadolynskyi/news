//
//  DiskCache.swift
//  News
//
//  Created by Paul Nadolynskyi on 8/21/19.
//  Copyright © 2019 paul. All rights reserved.
//

import Foundation

class DiskCache: Cache {
    private var cacheFolderName = "Cache"
    private var baseURL: URL? {
        guard let cacheFolderURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return cacheFolderURL.appendingPathComponent(cacheFolderName)
    }
    
    private func createCacheFolderIfNeeded() {
        if let baseURL = baseURL,
            !FileManager.default.fileExists(atPath: baseURL.path) {
            try? FileManager.default.createDirectory(at: baseURL,
                                                     withIntermediateDirectories: true,
                                                     attributes: nil)
        }
    }
    
    private func cacheFileURL(key: String) -> URL? {
        guard let baseURL = baseURL,
            let path = key.addingPercentEncoding(withAllowedCharacters: .alphanumerics) else { return nil }
        return baseURL.appendingPathComponent(path)
    }
    
    func save(data: Data, key: String) {
        guard let cacheFileURL = cacheFileURL(key: key) else { return }
        createCacheFolderIfNeeded()
        do {
            try data.write(to: cacheFileURL)
        } catch {
            print(error)
        }
    }
    
    func load(key: String) -> Data? {
        guard let cacheFileURL = cacheFileURL(key: key),
            FileManager.default.fileExists(atPath: cacheFileURL.path) else { return nil }
        
        do {
            return try Data(contentsOf: cacheFileURL)
        } catch {
            print(error)
            return nil
        }
    }
    
    func clear() {
        guard let baseURL = baseURL,
            FileManager.default.fileExists(atPath: baseURL.path) else { return }
        
        do {
            try FileManager.default.removeItem(at: baseURL)
        } catch {
            print(error)
        }
    }
}
