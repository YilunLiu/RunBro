//
//  MenuListTableViewController.swift
//  RunBro
//
//  Created by Yilun Liu on 4/4/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//

import UIKit

class MenuListTableViewController: UITableViewController, MenuItemCellDelegate {

    
    var items: [MenuItem]!
    
    
    var totalPrice: Double {
        var totalPrice = 0.0
        
        for item in items {
            totalPrice += Double(item.quantity) * item.price
        }
        return totalPrice
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuItemCell", forIndexPath: indexPath) as MenuItemCell
        cell.delegate = self
        cell.nameLabel.text = items[indexPath.row].name
        cell.priceLabel.text = "\(items[indexPath.row].price)"
        cell.quantityLabel.text = "\(items[indexPath.row].quantity)"
        return cell
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if let destination = segue.destinationViewController as? UIViewController {
            if segue.identifier == "FoodCheckout" {
                let foodCheckoutViewController = destination as FoodCheckoutViewController
                foodCheckoutViewController.items = self.items
            }
        }
        
        
    }
    
    // MARK: - MenuItemCellDelegate
    func minusPressedForCell(cell: MenuItemCell) {
        let indexPath = self.tableView.indexPathForCell(cell)!
        if items[indexPath.row].quantity == 0 {
            return
        }
        items[indexPath.row].quantity--
        cell.quantityLabel.text = "\(items[indexPath.row].quantity)"
        updateCheckoutButton()
    }
    
    func plusPressedForCell(cell: MenuItemCell) {
        let indexPath = self.tableView.indexPathForCell(cell)!
        items[indexPath.row].quantity++
        cell.quantityLabel.text = "\(items[indexPath.row].quantity)"
        updateCheckoutButton()
    }
    
    // Mark: - Target & Action
    
    
    // Mark: - Private Helper Method
    func updateCheckoutButton() {
        self.navigationItem.rightBarButtonItem?.title = "Checkout ($\(self.totalPrice))"
    }
    

}
