//
//  PostBuilder.swift
//  News
//
//  Created by Paul Nadolynskyi on 8/21/19.
//  Copyright © 2019 paul. All rights reserved.
//

import UIKit

class PostBuilder: PostBuild {
    class func instantiateScreen(post: Post, dataProvider: DataProvider) -> PostViewController? {
        let storyboard = UIStoryboard(name: "Post", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "PostViewController") as? PostViewController else {
            return nil
        }
        
        let router = PostRouter(vc: vc)
        
        let presenter = PostPresenter(router: router, view: vc, post: post, dataProvider: dataProvider)
        
        vc.presenter = presenter
        
        return vc
    }
}
