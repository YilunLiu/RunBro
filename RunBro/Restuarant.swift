//
//  Restuarant.swift
//  RunBro
//
//  Created by Yilun Liu on 4/4/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//

import UIKit

class Restaurant: PFObject, PFSubclassing {
   
    @NSManaged var name: String
    @NSManaged var location: PFGeoPoint
    @NSManaged private(set) var itemsRelation: PFRelation
    @NSManaged var pictureFile: PFFile
    var items = [MenuItem]()
    
    
    lazy var picture: UIImage = {
        //Need to Fix: taking too much time on main thread
        return UIImage(data: self.pictureFile.getData()!)!
    }()
    
    
    
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken){
            self.registerSubclass()
        }
    }
    
    class func parseClassName() -> String {
        return "Restuarant"
    }
    
    
    override init() {
        super.init()
        
        
    }
}
