//
//  FixtureManager.swift
//  RunBro
//
//  Created by Yilun Liu on 3/26/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//

import Foundation

class FixtureManager: NSObject{

    var orders = [Order]()
    
    class var sharedInstance: FixtureManager {
        struct Static {
            static var instance: FixtureManager?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token){
            Static.instance = FixtureManager()
            Static.instance?.loadOrderData()
        }
        
        return Static.instance!
    }
    
    
    func createUser(){
        
        var userZero = PFUser()
        
        var userA = RBUser()
        userA.username = "1245512222"
        userA.password = "lordoftherings"
        userA.phoneNumber = 1245512222
        userA.firstName = "Frodo"
        userA.lastName = "Baggins"
        
        
        userA.profilePicture = PFFile(data: UIImagePNGRepresentation(UIImage(named: "Aragorn.jpg")))
        userA.profilePicture.saveInBackground()
        userA.signUp()
        
        
        var userB = RBUser()
        userB.username = "1245512223"
        userB.password = "lordoftherings"
        userB.phoneNumber = 1245512223
        userB.firstName = "Aragorn"
        userB.lastName = "Elessar"
        
        userB.profilePicture = PFFile(data: UIImagePNGRepresentation(UIImage(named: "Frodo.jpg")))
        userB.profilePicture.saveInBackground()
        userB.signUp()
        
        
    }
    
    
    private func loadOrderData(){
        for i in 0...7{
            
            var image = UIImage(named: "\(i).jpg")
            
            var order = Order()
            order.comments = ["good job","bla","blablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablabla"]
            order.imageFile = PFFile(data: UIImagePNGRepresentation(image))
            order.locationDetails = "59102 7th street"
            order.title = "I want something"
            order.deliverTime = NSDate()
            order.setStaus(OrderStatus(rawValue: i % 3)!)
            order.detials = "something from somewhere with something"
            order.totalPrice = 5
            
            
            
            
            orders.append(order)
        }
    }
}