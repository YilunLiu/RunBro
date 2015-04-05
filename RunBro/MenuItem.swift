//
//  MenuItem.swift
//  RunBro
//
//  Created by Yilun Liu on 4/4/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//

import UIKit

class MenuItem: PFObject, PFSubclassing {
    
    @NSManaged var name: String
    @NSManaged var price: Double
    
    var quantity = 0
    
    class func parseClassName() -> String {
        return "MenuItem"
    }
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken){
            self.registerSubclass()
        }
    }
    
    override init() {
        super.init()
        
        
    }
}
