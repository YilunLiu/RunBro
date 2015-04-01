//
//  RBUser.swift
//  RunBro
//
//  Created by Yilun Liu on 3/30/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//

class RBUser: PFUser,PFSubclassing {
    
    @NSManaged var phoneNumber: Int
    @NSManaged var profilePicture: PFFile
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    
    
    
    override init() {
        super.init()
    }
    
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken){
            self.registerSubclass()
        }
    }
    
}

