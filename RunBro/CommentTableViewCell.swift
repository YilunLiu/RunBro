//
//  CommentTableViewCell.swift
//  RunBro
//
//  Created by Yilun Liu on 3/27/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//

import UIKit

var CommentTableViewCellIdentifier = "CommentTableViewCell"

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var commentContent: UITextView!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
}
