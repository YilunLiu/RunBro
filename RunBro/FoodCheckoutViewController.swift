//
//  FoodCheckoutViewController.swift
//  RunBro
//
//  Created by Yilun Liu on 4/4/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//

import UIKit

class FoodCheckoutViewController: UITableViewController {

    @IBOutlet var placeOrderButtons: [UIButton]!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var endingLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var itemTotalPriceLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var estimatedTaxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var deliveryFeeTextField: UITextField!
    
    var itemTotalPrice: Double {
        var total = 0.0
        for item in items {
            total += item.price * Double(item.quantity)
        }
        return total
    }
    
    var deliveryFee: Double {
        var intValue = deliveryFeeTextField.text.toInt() ?? 0
        return Double(intValue) / 100.0
    }
    
    
    var order = Order()
    var items : [MenuItem]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.itemTotalPriceLabel.text = formatStringWithDollar(itemTotalPrice)
        self.estimatedTaxLabel.text = formatStringWithDollar(itemTotalPrice * 0.085)
        self.totalLabel.text = formatStringWithDollar(itemTotalPrice * 0.085 + deliveryFee)
        self.detailTextView.text = prepareForDetails()
        
        
        var tabDissmissGesture = UITapGestureRecognizer(target: self, action: Selector("dismissTextField"))
        self.view.addGestureRecognizer(tabDissmissGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    // MARK: - Table view data source
//
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete method implementation.
//        // Return the number of rows in the section.
//        return 0
//    }
//
//    /*
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
//
//        // Configure the cell...
//
//        return cell
//    }
//    */

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

    // Mark: - Textfield Delegate

    
    
    
    // Mark: - Target & Action
    @IBAction func placeOrderPressed(sender: AnyObject) {
        
    }
    
    
    // Mark: - Helper 
    private func formatStringWithDollar(amount: Double) -> String{
        return String(format: "$%.2f", amount)
    }
    
    private func prepareForDetails() -> String {
        var details = ""
        for item in items {
            if item.quantity != 0 {
                details += "\(item.name) * \(item.quantity) \n"
            }
        }
        return details
    }
    
     func dismissTextField(){
        self.deliveryFeeTextField.resignFirstResponder()
    }
    
    
}
