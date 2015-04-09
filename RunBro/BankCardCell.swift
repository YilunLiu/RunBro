//
//  BankCardCell.swift
//  RunBro
//
//  Created by Yilun Liu on 4/8/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//

import UIKit

class BankCardCell: UITableViewCell {

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var endingLabel: UILabel!
    @IBOutlet weak var defaultLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
