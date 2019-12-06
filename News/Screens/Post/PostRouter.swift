//
//  PostRouter.swift
//  News
//
//  Created by Paul Nadolynskyi on 8/20/19.
//  Copyright © 2019 paul. All rights reserved.
//

import UIKit

class PostRouter: PostViewRouter {
    fileprivate weak var mainViewController: UIViewController?
    
    init(vc: UIViewController) {
        self.mainViewController = vc
    }
}
