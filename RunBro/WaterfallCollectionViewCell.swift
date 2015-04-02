//
//  WaterfallCollectionViewCell.swift
//  RunBro
//
//  Created by Yilun Liu on 3/8/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//

import UIKit


let WaterViewCellIdentifier = "Waterfallell"

class WaterfallCollectionViewCell: UICollectionViewCell {
    
    var Identifier = "WaterfallCollectionViewCell"
    
    var imageView: UIImageView = UIImageView()
    var titleLabel: UILabel = UILabel()
    var bottomTimeLabel: UILabel = UILabel()
    var bottomDistanceLabel: UILabel = UILabel()
    var bottomCommentLabel: UILabel = UILabel()
    var bottomView: UIView!
    
    var bottomViewContent: UIView {
        get{
            if bottomView.isKindOfClass(UIVisualEffectView){
                return (bottomView as UIVisualEffectView).contentView
            }
            else {
                return bottomView
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //imageView
        imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
//        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        //title
        titleLabel.frame = CGRectMake(0, 0, frame.width, 20)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.backgroundColor = UIColor.blackColor()
        titleLabel.alpha = 0.7
      
        if (UIDevice.currentDevice().systemVersion as NSString).floatValue < 8.0 {
            bottomView = UIView()
            bottomView.backgroundColor = UIColor.grayColor()
            bottomView.alpha = 0.5
            
        }
        else{
            bottomView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
        }
        
        
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(bottomView)
        self.bottomViewContent.addSubview(bottomCommentLabel)
        self.bottomViewContent.addSubview(bottomDistanceLabel)
        self.bottomViewContent.addSubview(bottomTimeLabel)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        titleLabel.frame = CGRectMake(0, 0, frame.width, 20)
        bottomView.frame = CGRectMake(0, frame.height - 30, frame.width, 30)
    }
    
}
