//
//  BankCardManager.swift
//  RunBro
//
//  Created by Yilun Liu on 4/8/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//

import UIKit

@objc protocol BankCardManagerDelegate {
    func bankCardsChanged()
}

class BankCardManager: NSObject {
   
    
    // singleton
    class var sharedInstance: BankCardManager {
        struct Static {
            static let instance: BankCardManager = BankCardManager()

        }

        
        return Static.instance
    }
    
    var cards = [BankCard]()
    var delegate: BankCardManagerDelegate?
    
    var defaultCard: BankCard? {
        for card in cards {
            if card.isDefault{
               return card
            }
        }
        return nil
    }
    
    override init() {
        super.init()
    }
    
    
    func loadCardInforamtionInBackground(){
        var query = BankCard.query()
        query.fromLocalDatastore()
        query.whereKey("owner", equalTo: PFUser.currentUser())
        query.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]!, error: NSError!)-> Void in
            if error == nil {
                self.cards = objects as [BankCard]
            }
        }
    }
    
    func saveCardInformationInBackground(){
        PFObject.pinAllInBackground(self.cards)
    }
    
    func addCard(card:BankCard){
        
        if self.defaultCard == nil {
            card.setDefault()
        }
        
        cards.append(card)
        card.pinInBackground()
        
        self.delegate?.bankCardsChanged()
        
        
    }
    
    
    func deleteCard(card: BankCard){
        
        var defaultCard = self.defaultCard
        var index = find(cards, card)
        cards.removeAtIndex(index!)
        
        
        if defaultCard == card && self.cards.count > 0{
            self.cards[0].setDefault()
        }
        card.unpinInBackground()
        
        self.delegate?.bankCardsChanged()
    }
    
}
