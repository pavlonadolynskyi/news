//
//  FeedBuilder.swift
//  News
//
//  Created by Paul Nadolynskyi on 8/20/19.
//  Copyright © 2019 paul. All rights reserved.
//

import UIKit

class FeedBuilder: FeedBuild {
    class func instantiateScreen(dataProvider: DataProvider) -> FeedViewController? {
        let storyboard = UIStoryboard(name: "Feed", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "FeedViewController") as? FeedViewController else {
            return nil
        }
        
        let router = FeedRouter(vc: vc)
        
        let presenter = FeedPresenter(view: vc, router: router, dataProvider: dataProvider)
        
        vc.presenter = presenter
        
        return vc
    }
}
