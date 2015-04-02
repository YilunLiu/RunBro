//
//  HomeFilterView.swift
//  RunBro
//
//  Created by Yilun Liu on 3/17/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//

import UIKit

class CollectionFilterView: UICollectionReusableView {

   
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        var label = UILabel()
        label.frame = CGRectMake(0, 0, frame.width, frame.height)
        label.text = "Hello"
        self.addSubview(label)
        
        
    }
}
