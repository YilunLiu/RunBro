//
//  Order.swift
//  RunBro
//
//  Created by Yilun Liu on 3/30/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//

class Order: PFObject, PFSubclassing {
    @NSManaged var requester: PFUser
    @NSManaged var requestTaker: PFUser
    @NSManaged var imageFile: PFFile
    @NSManaged var location: PFGeoPoint?
    @NSManaged var locationDetails: String
    @NSManaged var title: String
    @NSManaged var totalPrice: Double
    @NSManaged var deliverTime: NSDate
    @NSManaged var detials: String
    @NSManaged var comments: [String]
    @NSManaged private var status: OrderStatus.RawValue
    
    
    func orderPersonTypeForUser(user: PFUser) -> OrderPersonType{
        if user == requester {
            return .Requester
        }
        else if user == requestTaker {
            return .Taker
        }
        else{
            return .None
        }
    }
    
    lazy var image: UIImage = {
        
        
        //Need to Fix: taking too much time on main thread
        return UIImage(data: self.imageFile.getData()!)!
        }()
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken){
            self.registerSubclass()
        }
    }
    
    class func parseClassName() -> String {
        return "Order"
    }
    
    
    override init() {
        super.init()
        
        
    }
    
    
    func getStatus() -> OrderStatus {
        return OrderStatus(rawValue: self.status)!
    }
    
    func setStaus(status: OrderStatus){
        self.status = status.rawValue
    }
    
    
    
}

enum OrderStatus: Int {
    case Waiting = 0
    case InProcess = 1
    case Completed = 2
    case Preview = 3
}

enum OrderPersonType: Int{
    case Requester = 0
    case Taker = 1
    case None = 2
}
