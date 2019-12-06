//
//  Post.swift
//  News
//
//  Created by Paul Nadolynskyi on 8/20/19.
//  Copyright © 2019 paul. All rights reserved.
//

import UIKit

class Post: Codable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
