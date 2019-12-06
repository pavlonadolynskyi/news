//
//  FeedPresenter.swift
//  News
//
//  Created by Paul Nadolynskyi on 8/20/19.
//  Copyright © 2019 paul. All rights reserved.
//

import Foundation

class FeedPresenter: FeedPresentation {
    internal var router: FeedViewRouter
    private weak var view: FeedView?
    private var dataProvider: DataProvider
    
    internal var sections: [ListDisplaySection<Post>] = []

    private var items: [Post] = []
    private var isLoading = false
    
    var title: String {
        return NSLocalizedString("feedTitle", comment: "")
    }
    
    init(view: FeedView, router: FeedViewRouter, dataProvider: DataProvider) {
        self.view = view
        self.router = router
        self.dataProvider = dataProvider
    }
    
    func viewDidLoad() {
        load()
    }
    
    func refresh() {
        load()
    }
    
    func showDetails(_ item: Post) {
        router.showDetails(item, dataProvider: dataProvider)
    }
    
    private func load() {
        if isLoading { return }
        isLoading = true
        
        view?.setRefreshing(true)
        dataProvider.fetchPosts { (posts, error) in
            self.view?.setRefreshing(false)

            self.items = posts ?? []
            self.isLoading = false
            
            self.sections = self.sectionsFor(items: self.items, error: error)
            self.view?.updateContent()
        }
    }
    
    private func sectionsFor(items: [Post], error: Error?) -> [ListDisplaySection<Post>] {
        var sections = [ListDisplaySection<Post>]()
        if let error = error {
            sections.append(ListDisplaySection.noItems(message: error.localizedDescription))
        } else {
            sections.append(ListDisplaySection.items(items))
        }
        return sections
    }
}
