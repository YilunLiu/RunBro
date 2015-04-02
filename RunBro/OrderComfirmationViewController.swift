//
//  OrderComfirmationViewController.swift
//  RunBro
//
//  Created by Yilun Liu on 3/28/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//

import UIKit


@objc protocol OrderComfirmationViewControllerDelegate {
    
    optional func orderTitleForViewController(controller: OrderComfirmationViewController) -> String
    optional func comfirmationMessageForViewController(controller: OrderComfirmationViewController) ->String
    optional func orderBarcodeForViewController(controller: OrderComfirmationViewController) -> UIImage
}



class OrderComfirmationViewController: UIViewController {

    
    
    @IBOutlet weak var barcodeImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var delegate: OrderComfirmationViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationBar.topItem?.title = self.delegate?.orderTitleForViewController?(self) ?? ""
        self.barcodeImageView.image = self.delegate?.orderBarcodeForViewController?(self)
        self.messageLabel.text = self.delegate?.comfirmationMessageForViewController?(self) ?? ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func doneButtonPressed(sender: UIButton) {
    }
}
