//
//  FeedRouter.swift
//  News
//
//  Created by Paul Nadolynskyi on 8/20/19.
//  Copyright © 2019 paul. All rights reserved.
//

import UIKit

class FeedRouter: FeedViewRouter {
    fileprivate weak var mainViewController: UIViewController?
    
    init(vc: UIViewController) {
        self.mainViewController = vc
    }
    
    func showDetails(_ item: Post, dataProvider: DataProvider) {
        guard let nc = mainViewController?.navigationController,
            let vc = PostBuilder.instantiateScreen(post: item, dataProvider: dataProvider) else {
            fatalError("View Instantiation")
        }
        nc.pushViewController(vc, animated: true)
    }
}
