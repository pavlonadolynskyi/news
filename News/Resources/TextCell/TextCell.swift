//
//  TextCell.swift
//  News
//
//  Created by Paul Nadolynskyi on 8/20/19.
//  Copyright © 2019 paul. All rights reserved.
//

import UIKit

class TextCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    
    func show(text: String) {
        titleLabel.text = text
    }

    static func heightFor(_ size: CGSize) -> CGFloat {
        return UITableView.automaticDimension
    }
}
