//
//  FeedContract.swift
//  News
//
//  Created by Paul Nadolynskyi on 8/20/19.
//  Copyright © 2019 paul. All rights reserved.
//

import Foundation

protocol FeedBuild {
    static func instantiateScreen(dataProvider: DataProvider) -> FeedViewController?
}

protocol FeedViewRouter {
    func showDetails(_ item: Post, dataProvider: DataProvider)
}

protocol FeedPresentation: ViewPresentation {
    var router: FeedViewRouter { get }
    var title: String { get }
    var sections: [ListDisplaySection<Post>] { get }
    func refresh()
    func showDetails(_ item: Post)
}

protocol FeedView: AppView {
    func updateContent()
    func setRefreshing(_ on: Bool)
}
