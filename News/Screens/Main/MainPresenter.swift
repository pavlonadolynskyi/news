//
//  MainPresenter.swift
//  News
//
//  Created by Paul Nadolynskyi on 8/20/19.
//  Copyright © 2019 paul. All rights reserved.
//

import Foundation

class MainPresenter: MainPresentation {
    private weak var router: MainWireframe?
    
    init(router: MainWireframe) {
        self.router = router
    }
    
    func instantiateFlow() {
        router?.startFromNewsFeed()
    }
}
