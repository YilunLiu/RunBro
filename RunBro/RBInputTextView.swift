//
//  RBInputTextView.swift
//  RunBro
//
//  Created by Yilun Liu on 3/7/15.
//  Copyright (c) 2015 RunBro. All rights reserved.
//

import UIKit

protocol RBInputTextViewDelegate{
    func textFieldDidEndEditing(textField: UITextField, fromView inputView: RBInputTextView)
}



class RBInputTextView: UIView, UITextFieldDelegate {

    var IMAGE_SIZE: CGFloat = 30
    var PADDING: CGFloat = 8
    var BUTTON_SIZE: CGFloat = 30
    var TEXTFIELD_HEIGHT:CGFloat = 30
    
    var imageView: UIImageView = UIImageView()
    var textField: UITextField = UITextField()
    var statusButton: UIButton = UIButton()
    
    
    var imageName: String!
    var fieldName: String!
    
    var delegate: RBInputTextViewDelegate!
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        imageView.frame = CGRectMake(PADDING, self.bounds.height - IMAGE_SIZE, IMAGE_SIZE, IMAGE_SIZE)
        imageView.backgroundColor = UIColor.grayColor()
        self.addSubview(imageView)
        
        textField.frame = CGRectMake(PADDING * 2 + IMAGE_SIZE, self.bounds.height - TEXTFIELD_HEIGHT, self.bounds.width - PADDING * 2 - IMAGE_SIZE, TEXTFIELD_HEIGHT)
        textField.delegate = self
        textField.placeholder = fieldName
        var bottomBorder = CALayer()
        bottomBorder.frame = CGRectMake(0.0, textField.frame.size.height - 1, textField.frame.size.width, 1.0);
        bottomBorder.backgroundColor = UIColor.grayColor().CGColor
        textField.layer.addSublayer(bottomBorder)
        
        statusButton.frame = CGRectMake(self.bounds.width - PADDING - BUTTON_SIZE, self.bounds.height - BUTTON_SIZE, BUTTON_SIZE, BUTTON_SIZE)
        statusButton.backgroundColor = UIColor.grayColor()
        self.addSubview(statusButton)
        
        self.addSubview(textField)
        
        
    }
    

    func textFieldDidEndEditing(textField: UITextField) {
        delegate.textFieldDidEndEditing(textField, fromView: self)
    }
    

    

}
