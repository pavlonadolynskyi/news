//
//  PostDisplaySection.swift
//  News
//
//  Created by Paul Nadolynskyi on 8/22/19.
//  Copyright © 2019 paul. All rights reserved.
//

import Foundation

enum PostDisplaySection {
    case header(_ text: String)
    case text(_ text: String)
    case user(_ user: User)
    case comments(_ comments: [Comment])
    case noContent(message: String?)
}

