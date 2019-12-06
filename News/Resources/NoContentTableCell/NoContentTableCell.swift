//
//  NoContentTableCell.swift
//  News
//
//  Created by Paul Nadolynskyi on 8/20/19.
//  Copyright © 2019 paul. All rights reserved.
//

import UIKit

class NoContentTableCell: UITableViewCell {
    @IBOutlet private weak var iconLabel: UILabel!
    @IBOutlet private weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
    }
    
    func show(info: String?) {
        infoLabel.text = info
    }
}
