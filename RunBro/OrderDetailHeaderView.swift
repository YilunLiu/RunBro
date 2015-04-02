//
//  OrderDetailHeaderView.swift
//  RunBro
//
//  Created by Yilun Liu on 3/27/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//

import UIKit

@objc protocol OrderDetailHeaderViewDelegate {
    func imageForOrderDetailHeaderView(orderDetailHeaderView: UIView) -> UIImage
    func titleForOrderDetailHeaderView(orderDetailHeaderView: UIView) -> String
    func addressForOrderDetailHeaderView(orderDetailHeaderView: UIView) -> String
    func orderDetailForOrderDetailHeaderView(orderDetailHeaderView: UIView) -> String
    func statusViewForOrderDetailHeaderView(orderDetailHeaderView: UIView) -> UIView
    func timeToDisplayForOrderDetailHeaderView(orderDetailHeaderView: UIView) -> String
    func reloadSuperviewToRejustFrameChange()
}

class OrderDetailHeaderView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    let padding:CGFloat = 8.0
    let statusViewHeight:CGFloat = 50
    
    var delegate: OrderDetailHeaderViewDelegate?
    
    
    var imageView = UIImageView()
    var titleLabel = UILabel(frame: CGRectMake(100, 1001, 100, 100))
    var addressLabel = UILabel()
    var orderDetailLabel = UILabel()
    var timeLabel = UILabel()
    var statusView : UIView!
    
    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(orderDetailLabel)
        addSubview(titleLabel)
        addSubview(addressLabel)
        addSubview(timeLabel)
        
        titleLabel.font = UIFont(name: FONT_NAME, size: 25)
        orderDetailLabel.font = UIFont(name: FONT_NAME, size: 15)
        addressLabel.font = UIFont(name: FONT_NAME, size: 15)
        addressLabel.textColor = UIColor.grayColor()
        timeLabel.font = UIFont(name: FONT_NAME, size: 20)
        timeLabel.textColor = UIColor.redColor()
        
        

        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        
        
        if let image = delegate?.imageForOrderDetailHeaderView(self) {
            
            let imageSize = image.size
            let imageWidth = frame.size.width
            let imageHeight = imageSize.height * imageWidth / imageSize.width
            imageView.frame = CGRectMake(0, 0, imageWidth, imageHeight)
            imageView.image = image
        }
        else{
            imageView.frame = CGRectMake(0, 0, 0, 0)
        }
        
        let title = delegate?.titleForOrderDetailHeaderView(self) ?? "Title"
        titleLabel.text = title
        titleLabel.sizeToFit()
        titleLabel.frame.origin = CGPointMake(padding, CGRectGetMaxY(imageView.frame) + padding)
        
        
        let orderDetail = delegate?.orderDetailForOrderDetailHeaderView(self) ?? "OrderDetail"
        orderDetailLabel.text = orderDetail
        orderDetailLabel.sizeToFit()
        orderDetailLabel.frame.origin = CGPointMake(padding, CGRectGetMaxY(titleLabel.frame) + padding)
        
        let address = delegate?.addressForOrderDetailHeaderView(self) ?? "address"
        addressLabel.text = address
        addressLabel.sizeToFit()
        addressLabel.frame.origin = CGPointMake(padding, CGRectGetMaxY(orderDetailLabel.frame) + padding)
        
        let time = delegate?.timeToDisplayForOrderDetailHeaderView(self) ?? "time"
        timeLabel.text = time
        timeLabel.sizeToFit()
        timeLabel.frame.origin = CGPointMake(padding, CGRectGetMaxY(addressLabel.frame) + padding)
        
        
        if self.statusView == nil {
            statusView = self.delegate?.statusViewForOrderDetailHeaderView(self) ?? UIView(frame: CGRectMake(0, CGRectGetMaxY(timeLabel.frame) + padding, self.bounds.width, statusViewHeight))
            self.addSubview(statusView)
        }
        statusView.frame.origin = CGPointMake(0, CGRectGetMaxY(timeLabel.frame) + padding)
        
        self.frame.size = CGSizeMake(frame.width, CGRectGetMaxY(statusView.frame) + padding)
        self.delegate?.reloadSuperviewToRejustFrameChange()
        
        
        
    }
}
