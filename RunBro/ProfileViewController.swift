//
//  ProfileViewController.swift
//  RunBro
//
//  Created by Yilun Liu on 3/28/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {

    var orders = FixtureManager.sharedInstance.orders
    
    let HeaderHeight:CGFloat = 40
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    @IBOutlet weak var myOrderCollectionView: UICollectionView!
    @IBOutlet weak var myJobsCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //set layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        layout.minimumLineSpacing = 10.0
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        myJobsCollectionView.setCollectionViewLayout(layout, animated: false)
        myJobsCollectionView.backgroundColor = UIColor.clearColor()
        myJobsCollectionView.showsHorizontalScrollIndicator = false
        
        let layoutCopy = UICollectionViewFlowLayout()
        layoutCopy.scrollDirection = UICollectionViewScrollDirection.Horizontal
        layoutCopy.minimumLineSpacing = 10.0
        layoutCopy.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        myOrderCollectionView.setCollectionViewLayout(layoutCopy, animated: false)
        myOrderCollectionView.backgroundColor = UIColor.clearColor()
        myOrderCollectionView.showsHorizontalScrollIndicator = false
        
        //register
        myJobsCollectionView.registerNib(UINib(nibName: "OrderCollectionViewFlowLayoutCell", bundle: nil), forCellWithReuseIdentifier: "OrderCollectionViewFlowLayoutCell")
        myOrderCollectionView.registerNib(UINib(nibName: "OrderCollectionViewFlowLayoutCell", bundle: nil), forCellWithReuseIdentifier: "OrderCollectionViewFlowLayoutCell")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: collection view delegate flow layout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if collectionView == myOrderCollectionView {
            let cellHight = myOrderCollectionView.frame.height - 10 * 2
            let cellWidth = cellHight * 0.6
            return CGSizeMake(cellWidth, cellHight)
        }
        else if collectionView == myJobsCollectionView {
            let cellHight = myJobsCollectionView.frame.height - 10 * 2
            let cellWidth = cellHight * 0.6
            return CGSizeMake(cellWidth, cellHight)
        }
        else {
            return CGSizeZero
        }

    }
    
    
    
    // Mark: collection view datasource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == myOrderCollectionView {
            return orders.count
        }
        else if collectionView == myJobsCollectionView {
            return orders.count
        }
        else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("OrderCollectionViewFlowLayoutCell", forIndexPath: indexPath) as OrderCollectionViewFlowLayoutCell
        cell.backgroundColor = UIColor.redColor()
        
        return cell
        
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
