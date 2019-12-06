//
//  ListDisplaySection.swift
//  News
//
//  Created by Paul Nadolynskyi on 8/20/19.
//  Copyright © 2019 paul. All rights reserved.
//

import Foundation

enum ListDisplaySection<T> {
    case items(_ items: [T])
    case noItems(message: String?)
}
