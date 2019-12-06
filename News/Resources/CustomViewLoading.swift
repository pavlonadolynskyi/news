//
//  CustomViewLoading.swift
//  News
//
//  Created by Paul Nadolynskyi on 8/20/19.
//  Copyright © 2019 paul. All rights reserved.
//

import UIKit

protocol CustomViewLoading {
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
}

extension CustomViewLoading {
    static var reuseIdentifier: String { return String(describing: self) }
    static var nib: UINib? { return UINib(nibName: reuseIdentifier, bundle: nil) }
}

extension CustomViewLoading where Self: UITableViewCell {
    static func registerNib(_ tableView: UITableView) {
        tableView.register(self.nib, forCellReuseIdentifier: self.reuseIdentifier)
    }
    
    static func registerClass(_ tableView: UITableView) {
        tableView.register(self, forCellReuseIdentifier: self.reuseIdentifier)
    }
}

extension UITableViewCell: CustomViewLoading {}
