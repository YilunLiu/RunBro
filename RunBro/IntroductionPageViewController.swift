//
//  IntroductionPageViewController.swift
//  RunBro
//
//  Created by Yilun Liu on 3/7/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//

import UIKit

class IntroductionPageViewController: UIPageViewController, UIPageViewControllerDataSource {

    

    var contentDescription =  IntroductionDataModel().contentDescription
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let initialContentController = self.contentControllerAt(0)
        self.dataSource = self;
        
        self.setViewControllers([initialContentController], direction: .Forward, animated: false, completion: nil)
        
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var index = contentDescription.count;
        if let beforeController = viewController as? IntroductionPageContentViewController {
            index = beforeController.index
        }
        
        if (index >= (contentDescription.count - 1)) {
            return nil;
        }
        
        return self.contentControllerAt(index+1)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = -1;
        if let afterController =  viewController as? IntroductionPageContentViewController {
            index = afterController.index
        }
        
        if (index <= 0) {
            return nil
        }
        
        return self.contentControllerAt(index-1)
        
    }
    
    func contentControllerAt(index: Int) -> IntroductionPageContentViewController {

        var controller = self.storyboard?.instantiateViewControllerWithIdentifier("IntroductionPageContentViewController") as IntroductionPageContentViewController!
        controller.descriptionContent = contentDescription[index]
        controller.index = index
        return controller
    }
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return contentDescription.count
    }
    
    
}
