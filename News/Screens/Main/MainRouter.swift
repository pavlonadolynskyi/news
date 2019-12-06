//
//  MainRouter.swift
//  News
//
//  Created by Paul Nadolynskyi on 8/20/19.
//  Copyright © 2019 paul. All rights reserved.
//

import UIKit

class MainRouter: MainWireframe {
    private var presenter: MainPresenter?
    private var window: UIWindow?
    
    private var dataProvider: DataProvider
    
    init() {
        dataProvider = DataProvider(transport: HTTPTransport(), parser: JSONParser(), cache: DiskCache())

        presenter = MainPresenter(router: self)
    }
    
    func instantiateFlow(window: UIWindow?) {
        self.window = window
        presenter?.instantiateFlow()
    }
    
    func startFromNewsFeed() {
        guard let vc = FeedBuilder.instantiateScreen(dataProvider: dataProvider) else {
            fatalError("View Instantiation")
        }
        let nc = UINavigationController(rootViewController: vc)
        window?.rootViewController = nc
    }
}
