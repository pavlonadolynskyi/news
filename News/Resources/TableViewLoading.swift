//
//  TableViewLoading.swift
//  News
//
//  Created by Paul Nadolynskyi on 8/20/19.
//  Copyright © 2019 paul. All rights reserved.
//

import UIKit

protocol TableViewLoading: CustomViewLoading {
    func cell<T>(for indexPath: IndexPath) -> T where T: UITableViewCell
}

extension UITableView: TableViewLoading {
    func cell<T>(for indexPath: IndexPath) -> T where T: UITableViewCell {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to load cell")
        }
        return cell
    }
}

