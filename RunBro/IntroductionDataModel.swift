//
//  IntroductionDataModel.swift
//  RunBro
//
//  Created by Yilun Liu on 3/31/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//

class IntroductionDataModel: NSObject {
    
    
    class var sharedInstance: IntroductionDataModel {
        struct Static {
            static let instance: IntroductionDataModel = IntroductionDataModel()
        }
        return Static.instance
    }
    
    
    var contentDescription = ["Food and Things Delivery", "Make Friends", "Save Time and Get Helps"];
}
