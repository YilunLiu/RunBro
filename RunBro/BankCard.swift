//
//  BankCard.swift
//  RunBro
//
//  Created by Yilun Liu on 4/8/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//


class BankCard: PFObject, PFSubclassing {
    
    @NSManaged var token: String
    @NSManaged var lastFour: String
    @NSManaged var type: String
    @NSManaged var isDefault: Bool
    
    
    
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken){
            self.registerSubclass()
        }
    }
    
    class func parseClassName() -> String {
        return "BankCard"
    }
    
    
    override init() {
        super.init()
        
        
    }
    
}
