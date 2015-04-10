//
//  AddCardControlelr.swift
//  RunBro
//
//  Created by Yilun Liu on 4/8/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//

import UIKit

class AddCardController: UITableViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var monthYearLabel: UILabel!
    @IBOutlet weak var cvcLabel: UILabel!
    
    @IBOutlet var textFields: [UITextField]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        var tabDissmissGesture = UITapGestureRecognizer(target: self, action: Selector("dismissTextFields"))
        tabDissmissGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tabDissmissGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }
    */

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

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

    // Mark: - Tableview Delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        textFields[indexPath.row].becomeFirstResponder()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    
    //Mark: - TextField Changed
    @IBAction func cardNumberFieldChanged(sender: UITextField) {
        var rawinput = sender.text
        for i in 0 ..< countElements(rawinput)/4 {
            rawinput.insert(" ", atIndex: advance(rawinput.startIndex, 5 * i + 4))
        }
        cardNumberLabel.text = rawinput
    }

    @IBAction func monthYearFieldChanged(sender: UITextField) {
        var rawinput = sender.text
        
        if countElements(rawinput) >= 2 {
            rawinput.insert("/", atIndex: advance(rawinput.startIndex, 2))
        }
        
        monthYearLabel.text = rawinput
    }
    @IBAction func cvcFieldChanged(sender: UITextField) {
        var rawinput = sender.text
        cvcLabel.text = rawinput
    }
    
    //Mark: - TextField Delegate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var newLength = countElements(textField.text) + countElements(string) - range.length
        
        switch (textField){
        case textFields[0]:
            return newLength <= 16
        case textFields[1]:
            return newLength <= 4
        case textFields[2]:
            return newLength <= 3
        default:
            return true
        }
    }
    
    //Mark: - Helper
    func dismissTextFields() {
        self.view.endEditing(true)
    }
    
    
    //Mark: - Target Action
    @IBAction func AddButtonPressed(sender: AnyObject) {
        let cardNumber = textFields[0].text
        let expiration = textFields[1].text
        let month = expiration.substringToIndex(advance(expiration.startIndex, 2))
        let year = expiration.substringFromIndex(advance(expiration.startIndex, 2))
        let cvc = textFields[2].text
        
        var card = BankCard(cardNumber: cardNumber, exMonth: month, exYear: year, cvc: cvc)
        BankCardManager.sharedInstance.addCard(card)
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
}
