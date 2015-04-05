//
//  MenuItemCell.swift
//  RunBro
//
//  Created by Yilun Liu on 4/4/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//

import UIKit

@objc protocol MenuItemCellDelegate {
    optional func plusPressedForCell(cell: MenuItemCell)
    optional func minusPressedForCell(cell: MenuItemCell)
}

class MenuItemCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    var delegate: MenuItemCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // Mark: - Target & Action
    @IBAction func plusPressed(sender: AnyObject) {
        self.delegate?.plusPressedForCell?(self)
        
    }
    @IBAction func minusPressed(sender: AnyObject) {
        self.delegate?.minusPressedForCell?(self)
    }
}
