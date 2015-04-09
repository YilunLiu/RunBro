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
    var restuarants = [Restaurant]()
    var bankCards = [BankCard]()
    
    
    class var sharedInstance: FixtureManager {
        struct Static {
            static var instance: FixtureManager?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token){
            Static.instance = FixtureManager()
            Static.instance?.loadOrderData()
            Static.instance?.loadResturantData()
            Static.instance?.loadCardInfo()
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
    
    
    private func loadResturantData(){
        var image = UIImage(named: "BurgerKing.jpg")
        
        var restuarant = Restaurant()
        restuarant.pictureFile = PFFile(data: UIImagePNGRepresentation(image))
        restuarant.name = "Burger King"
        
        for i in 0...10 {
            var menuItem = MenuItem()
            menuItem.name = "Burger"
            menuItem.price = 3.75
            restuarant.items.append(menuItem)
            
            var menuItem2 = MenuItem()
            menuItem2.name = "Oreo Shake"
            menuItem2.price = 7.45
            restuarant.items.append(menuItem2)
            
        }
        
        restuarants.append(restuarant)
        
    }
    
    
    private func loadCardInfo(){
        var card1 = BankCard()
        card1.lastFour = "7825"
        card1.isDefault = true
        card1.token = "125sfjoasnc120zs"
        card1.type = "Visa"
        bankCards.append(card1)
        
        var card2 = BankCard()
        card2.lastFour = "7255"
        card2.isDefault = false
        card2.token = "125sfjoasnc120zs"
        card2.type = "Master"
        
        bankCards.append(card2)
    }
}