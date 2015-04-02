//
//  OrderTableViewController.swift
//  RunBro
//
//  Created by Yilun Liu on 3/27/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//

import UIKit

class OrderDetailViewController: UITableViewController, OrderDetailHeaderViewDelegate {

    
    var order: Order!
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //table header view
        var headerView = OrderDetailHeaderView(frame: CGRectMake(0, 0, view.frame.width, view.frame.height*2))
        self.tableView.contentInset = UIEdgeInsetsMake(CGRectGetMaxY(self.navigationController!.navigationBar.frame),0,100,0);
        headerView.delegate = self
        headerView.layoutIfNeeded()
        tableView.tableHeaderView = headerView
        
        //cell
//        tableView.registerNib(UINib(nibName: CommentTableViewCell.Identifier, bundle: nil), forCellReuseIdentifier: CommentTableViewCell.Identifier)
        
        //tableview configuration
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .None
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
        return  order.comments.count
    }
    
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CommentTableViewCellIdentifier, forIndexPath: indexPath) as CommentTableViewCell
        // Configure the cell...
        cell.commentContent.text = order.comments[indexPath.row]
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    //Mark: - HeaderView Delegate
    func imageForOrderDetailHeaderView(orderDetailHeaderView: UIView) -> UIImage{
        return order.image
    }
    func titleForOrderDetailHeaderView(orderDetailHeaderView: UIView) -> String{
        return order.title
    }
    func addressForOrderDetailHeaderView(orderDetailHeaderView: UIView) -> String {
        return order.locationDetails
    }
    func orderDetailForOrderDetailHeaderView(orderDetailHeaderView: UIView) -> String{
        return order.detials
    }
    func statusViewForOrderDetailHeaderView(orderDetailHeaderView: UIView) -> UIView {
        var frame = CGRectMake(0, 0, view.frame.width, (orderDetailHeaderView as OrderDetailHeaderView).statusViewHeight )
        switch order.getStatus() {
        case .Waiting:
            return OrderStatusWaitingView(frame: frame)
        case .InProcess:
            return OrderStatusInProcessView(frame: frame)
        case .Completed:
            return OrderStatusCompletedView(frame: frame)
        case .Preview:
            return OrderStatusPreviewView(frame: frame)
            
        }
    }
    func timeToDisplayForOrderDetailHeaderView(orderDetailHeaderView: UIView) -> String {
        return order.deliverTime.description
    }
    
    func reloadSuperviewToRejustFrameChange() {
    }
}
