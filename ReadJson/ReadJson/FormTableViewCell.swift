//
//  FormTableViewCell.swift
//  ReadJson
//
//  Created by Pengfei Chen on 16/6/28.
//  Copyright © 2016年 Zhen. All rights reserved.
//

import UIKit

class FormTableViewCell: UITableViewCell {

    @IBOutlet weak var formIdLabel: UILabel!
    @IBOutlet weak var formNameLabel: UILabel!
    @IBOutlet weak var formVersionLabel: UILabel!
    @IBOutlet weak var formDescriptionLabel: UILabel!
    @IBOutlet weak var formCountryfromLabel: UILabel!
    @IBOutlet weak var formCountrytoLabel: UILabel!
    @IBOutlet weak var formCountryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
