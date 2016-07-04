//
//  MessageTableViewCell.swift
//  MessageJson
//
//  Created by Pengfei Chen on 16/6/29.
//  Copyright © 2016年 Zhen. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var FromLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var BodyLabel: UILabel!
   
}
