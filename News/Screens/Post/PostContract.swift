//
//  PostContract.swift
//  News
//
//  Created by Paul Nadolynskyi on 8/20/19.
//  Copyright © 2019 paul. All rights reserved.
//

import UIKit

protocol PostBuild {
    static func instantiateScreen(post: Post, dataProvider: DataProvider) -> PostViewController?
}

protocol PostViewRouter {
}

protocol PostPresentation: ViewPresentation {
    var router: PostViewRouter { get }
    var title: String { get }
    var sections: [PostDisplaySection] { get }
    func refresh()
}

protocol PostView: AppView {
    func updateContent()
    func setRefreshing(_ on: Bool)
}
