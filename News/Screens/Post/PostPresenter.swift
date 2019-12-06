//
//  PostPresenter.swift
//  News
//
//  Created by Paul Nadolynskyi on 8/20/19.
//  Copyright © 2019 paul. All rights reserved.
//

import UIKit

class PostPresenter: PostPresentation {
    internal var router: PostViewRouter
    private weak var view: PostView?
    private var dataProvider: DataProvider
    private var post: Post
    
    var title: String { return post.title }
    
    var sections: [PostDisplaySection] = []
    
    private var user: User?
    private var userFetchError: Error?
    private var comments: [Comment]?
    private var commentsFetchError: Error?
    private var isLoading = false

    init(router: PostRouter, view: PostView, post: Post, dataProvider: DataProvider) {
        self.view = view
        self.router = router
        self.post = post
        self.dataProvider = dataProvider
    }
    
    func viewDidLoad() {
        load()
    }
    
    func refresh() {
        load()
    }
    
    private func load() {
        if isLoading { return }
        isLoading = true
        
        view?.setRefreshing(true)
        dataProvider.fetchPostInfo(postId: post.id, userId: post.userId) { (user, userFetchError, comments, commentsFetchError) in
            self.view?.setRefreshing(false)

            self.user = user
            self.userFetchError = userFetchError
            self.comments = comments
            self.commentsFetchError = commentsFetchError
            
            self.isLoading = false
            
            self.sections = self.sectionsFor(post: self.post,
                                             user: self.user, userFetchError: self.userFetchError,
                                             comments: self.comments, commentsFetchError: self.commentsFetchError)
            self.view?.updateContent()
        }
    }
    
    private func sectionsFor(post: Post,
                             user: User?, userFetchError: Error?,
                             comments: [Comment]?, commentsFetchError: Error?) -> [PostDisplaySection] {
        var sections = [PostDisplaySection]()
        let unableToFetchError = NSError(domain: "App", code: -1, userInfo: [
            NSLocalizedDescriptionKey: NSLocalizedString("errorUnableToFetchData", comment: "")])

        sections.append(PostDisplaySection.text(post.body))
        
        sections.append(PostDisplaySection.header(NSLocalizedString("generalAuthor", comment: "")))
        if let user = user {
            sections.append(PostDisplaySection.user(user))
        } else {
            let error = userFetchError ?? unableToFetchError
            sections.append(PostDisplaySection.noContent(message: error.localizedDescription))
        }
        sections.append(PostDisplaySection.header(NSLocalizedString("generalComments", comment: "")))
        if let comments = comments {
            sections.append(PostDisplaySection.comments(comments))
        } else {
            let error = commentsFetchError ?? unableToFetchError
            sections.append(PostDisplaySection.noContent(message: error.localizedDescription))
        }
        return sections
    }
}
