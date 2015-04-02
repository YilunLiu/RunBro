//
//  OrderStatusWaitingView.swift
//  RunBro
//
//  Created by Yilun Liu on 3/28/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//

import UIKit

class OrderStatusWaitingView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var messageLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(messageLabel)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = UIColor.redColor()
        
        messageLabel.frame = CGRect(origin: CGPointZero, size: self.frame.size)
        messageLabel.textAlignment = .Center
        messageLabel.textColor = UIColor.blackColor()
        messageLabel.text = "Wating For Taker"
        addSubview(messageLabel)
        
    }

}
