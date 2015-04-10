//
//  BankCardTableViewController.swift
//  RunBro
//
//  Created by Yilun Liu on 4/8/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//

import UIKit

class BankCardTableViewController: UITableViewController,BankCardManagerDelegate, UITableViewDelegate {

    let BankCardCellIdentifier = "BankCardCell"
    let AddCardCellIdentifier = "AddCardCell"
    
    
    let cardManager = BankCardManager.sharedInstance
    var cards: [BankCard] {
        return cardManager.cards
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        BankCardManager.sharedInstance.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        
        return 2
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        switch(section) {
        case 0:
            return cards.count
        case 1:
            return 1
        default:
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        switch(indexPath.section) {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(BankCardCellIdentifier, forIndexPath: indexPath) as BankCardCell
            cell.typeLabel.text = cards[indexPath.row].type
            cell.endingLabel.text = cards[indexPath.row].lastFour
            cell.defaultLabel.hidden = !cards[indexPath.row].isDefault
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(AddCardCellIdentifier, forIndexPath: indexPath) as UITableViewCell
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    // Mark: - UITableview Delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 1{
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            
            var cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            var setDefaultAction = UIAlertAction(title: "Set as Default", style: UIAlertActionStyle.Default, handler: {
                (action) -> Void in
                self.setDefaultCardAtIndex(indexPath.row)
            })
            alertController.addAction(setDefaultAction)
            
            var deleteAction = UIAlertAction(title: "Delete", style: .Default, handler: {
                (action) -> Void in
                self.deleteCardAtIndex(indexPath.row)
            })
            alertController.addAction(deleteAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }

        
        
    }
    
    //Mark: - BankCardManagerDelegate:
    func bankCardsChanged() {
        self.tableView.reloadData()
    }
    
    // Mark: - private helper
    private func setDefaultCardAtIndex(index: Int) {
        var card = cards[index]
        cardManager.defaultCard?.unSetDefault()
        card.setDefault()
        self.tableView.reloadData()
        
    }
    
    private func deleteCardAtIndex(index: Int) {
        var card = cards[index]
        cardManager.deleteCard(card)
        self.tableView.reloadData()
    }

}
