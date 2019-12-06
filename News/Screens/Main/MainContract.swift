//
//  MainContract.swift
//  News
//
//  Created by Paul Nadolynskyi on 8/20/19.
//  Copyright © 2019 paul. All rights reserved.
//

import UIKit

protocol MainWireframe: class {
    func instantiateFlow(window: UIWindow?)
    func startFromNewsFeed()
}

protocol MainPresentation {
    func instantiateFlow()
}
