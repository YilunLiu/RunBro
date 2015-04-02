//
//  OrderDetailManager.swift
//  RunBro
//
//  Created by Yilun Liu on 3/26/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//

import UIKit

@objc protocol OrderDetailManagerDatasource {
    
    
    func getOrderAtIndex(index: Int) -> Order
    func orderCount() -> Int
    
    optional func getOrders() -> [Order]
}



class OrderDetailManager: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var currentIndex = 0
    
    var orderDatasouce: OrderDetailManagerDatasource?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

            
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        var currenctViewController = orderDetailViewControllerAtIndex(currentIndex)
        self.automaticallyAdjustsScrollViewInsets = false
        self.dataSource = self
        self.setViewControllers([currenctViewController], direction: .Forward, animated: false, completion: nil)
    }
    
    func orderDetailViewControllerAtIndex(index: Int) -> OrderDetailViewController {
        let order = self.orderDatasouce?.getOrderAtIndex(index)
        let orderDetailViewController = storyboard?.instantiateViewControllerWithIdentifier("OrderDetailViewController") as OrderDetailViewController
        orderDetailViewController.order = order
        orderDetailViewController.index = index
        return orderDetailViewController
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        currentIndex = (viewController as OrderDetailViewController).index
        let orderNumbers = self.orderDatasouce!.orderCount()
        if (currentIndex >= orderNumbers - 1) {
            return nil
        }
        else{
            return orderDetailViewControllerAtIndex(currentIndex+1)
        }
        
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        currentIndex = (viewController as OrderDetailViewController).index
        if (currentIndex <= 0){
            return nil
        }
        else {
            return orderDetailViewControllerAtIndex(currentIndex-1)
        }
    }
    
    // MARK : UIPageViewControllerDelegate
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [AnyObject], transitionCompleted completed: Bool) {
    }
    
    
}
