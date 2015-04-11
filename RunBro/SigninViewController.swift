//
//  SigninViewController.swift
//  RunBro
//
//  Created by Yilun Liu on 3/7/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController, RBInputTextViewDelegate {

    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet var inputFields: [RBInputTextView]!
    
    let fieldNames = ["Phone Number", "Password"];
    
    var phoneNumber: String {
        return inputFields[0].text
    }
    
    var password: String {
        return inputFields[1].text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        for i in 0..<inputFields.count {
            var inputField = inputFields[i]
            inputField.delegate = self
            inputField.fieldName = fieldNames[i]
            
            
        }
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
    
    
    
    func textFieldDidEndEditing(textField: UITextField, fromView inputView: RBInputTextView) {
        RBUser()
    }
    
    @IBAction func goSignupPressed(sender: AnyObject) {
        if let vc = presentingViewController as? SignupViewController{
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            var toViewController = storyboard?.instantiateViewControllerWithIdentifier("SignupViewController") as SignupViewController
            self.presentViewController(toViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func forgetPasswordPressed(sender: AnyObject) {
    }

    @IBAction func signInPressed(sender: AnyObject) {
    }

    @IBAction func closeButtonPressed(sender: AnyObject) {
        self.view.endEditing(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
