//
//  CurrentViewController.swift
//  RunBro
//
//  Created by Yilun Liu on 3/29/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//

import UIKit

class CurrentViewController: UIViewController, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {

    
    var orders: [Order] = FixtureManager.sharedInstance.orders
    
    @IBOutlet weak var myCurrentOrdersCollectionView: UICollectionView!
    @IBOutlet weak var myCurrentJobsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let myOrdersFlowLayout = UICollectionViewFlowLayout()
        myOrdersFlowLayout.minimumLineSpacing = 10
        myOrdersFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 10)
        myOrdersFlowLayout.scrollDirection = .Vertical
        myCurrentOrdersCollectionView.setCollectionViewLayout(myOrdersFlowLayout, animated: false)
        myCurrentOrdersCollectionView.backgroundColor = UIColor.clearColor()
        
        let myJobsFlowLayout = UICollectionViewFlowLayout()
        myJobsFlowLayout.minimumLineSpacing = 10
        myJobsFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 0)
        myJobsFlowLayout.scrollDirection = .Vertical
        myCurrentJobsCollectionView.setCollectionViewLayout(myJobsFlowLayout, animated: false)
        myCurrentJobsCollectionView.backgroundColor = UIColor.clearColor()
        
        
        //register
        
        myCurrentOrdersCollectionView.registerClass(WaterfallCollectionViewCell.self, forCellWithReuseIdentifier: WaterViewCellIdentifier)
        myCurrentJobsCollectionView.registerClass(WaterfallCollectionViewCell.self, forCellWithReuseIdentifier: WaterViewCellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Mark: - FLow layout delegate
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let itemWidth = collectionView.frame.width - 10
        let imageSize = orders[indexPath.item].image.size
        let itemHeight = imageSize.height * itemWidth / imageSize.width
        return CGSizeMake(itemWidth, itemHeight)
    }
    
    // Mark: - CollectionViewDatasource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orders.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(WaterViewCellIdentifier, forIndexPath: indexPath) as WaterfallCollectionViewCell
        cell.imageView.image = orders[indexPath.item].image
        cell.titleLabel.text = orders[indexPath.item].title
        cell.setNeedsLayout()
        
        return cell
        
    }
    
    // Mark: -CollectionViewDelegate
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
