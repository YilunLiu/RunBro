//
//  HomeViewController.swift
//  RunBro
//
//  Created by Yilun Liu on 3/31/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//

import Foundation
import UIKit


let GRID_WIDTH: CGFloat = 155;
class HomeViewController: UICollectionViewController, WaterfallLayoutDelegate, OrderDetailManagerDatasource, CMPopTipViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var orders = FixtureManager.sharedInstance.orders 
    
    
    // Add Table View
    var addTableView = UITableView()
    
    let AddInfo = ["Order Food", "Personalize"]
    
    // MARK: - Life cycley
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        
        
        
        // self.clearsSelectionOnViewWillAppear = false
        
        // Do any additional setup after loading the view.
        var layout = WaterfallLayout()
        layout.columnCount = UIDevice.currentDevice().orientation == .Portrait ? 2 : 3
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        self.collectionView?.setCollectionViewLayout(layout, animated: false)
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        
        // Register cell classes
        self.collectionView!.registerClass(WaterfallCollectionViewCell.self, forCellWithReuseIdentifier: WaterViewCellIdentifier)
        self.collectionView?.registerClass(CollectionFilterView.self, forSupplementaryViewOfKind: WaterfallLayoutElementKindSectionHeader, withReuseIdentifier: "HeaderView")
        self.collectionView?.reloadData()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
    
    // MARK: CHTCollectionWaterfallLayout
    func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var image = orders[indexPath.item].image
        let imageHeight  = image.size.height * GRID_WIDTH / image.size.width
        return CGSizeMake(GRID_WIDTH, imageHeight)
    }
    
    func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, heightForHeaderInSection section: Int) -> CGFloat {
        return 60

    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "HeaderView" , forIndexPath: indexPath) as UICollectionReusableView
        return view
    }
    
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return orders.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(WaterViewCellIdentifier, forIndexPath: indexPath) as WaterfallCollectionViewCell
        cell.imageView.image = orders[indexPath.item].image
        cell.titleLabel.text = orders[indexPath.item].title
        
        return cell
    }
    
    
    
    // MARK: UICollectionViewDelegate
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var orderDetailManager = storyboard?.instantiateViewControllerWithIdentifier("OrderDetailManager") as OrderDetailManager
        orderDetailManager.orderDatasouce = self
        orderDetailManager.currentIndex = indexPath.item
        self.navigationController?.pushViewController(orderDetailManager, animated: false)
        
    }
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    */
    
    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    */
    
    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return false
    }
    
    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
    return false
    }
    
    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        super.willRotateToInterfaceOrientation(toInterfaceOrientation, duration: duration)
        var layout = self.collectionView?.collectionViewLayout as WaterfallLayout
        layout.columnCount = toInterfaceOrientation == .Portrait ? 2 : 3
    }
    
    //tableview datasource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView == addTableView {
            return 1
        }
        else {
            return 0
        }
    }
    
    
    //Mark: - Order Manager Datasource
    
    func getOrderAtIndex(index: Int) -> Order {
        return orders[index]
        
    }
    
    func orderCount() -> Int {
        return orders.count
    }
    
    //Mark: - Target Action
    @IBAction func addButtonPressed(sender: UIBarButtonItem) {

        
        var popView = CMPopTipView(message: "HelloHelloHelloHelloHello")
        popView.delegate = self
        popView.has3DStyle = false
        popView.hasShadow = false
        popView.dismissTapAnywhere = true
        popView.hasGradientBackground =  false
        popView.backgroundColor = UIColor.blackColor()
        popView.cornerRadius = 0.5
        popView.topMargin = 10
        popView.presentPointingAtBarButtonItem(sender, animated: true)
        
    }
    
    //PopView Delegate
    func popTipViewWasDismissedByUser(popTipView: CMPopTipView!) {
        
    }
}