//
//  OrderStatusPreviewView.swift
//  RunBro
//
//  Created by Yilun Liu on 3/28/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//

import UIKit

class OrderStatusPreviewView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    var messageLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = UIColor.redColor()
        
        messageLabel.frame = CGRect(origin: CGPointZero, size: self.frame.size)
        messageLabel.textAlignment = .Center
        messageLabel.textColor = UIColor.blackColor()
        messageLabel.text = "Publish"
        addSubview(messageLabel)
    }
}
