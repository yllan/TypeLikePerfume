//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Yung-Luen Lan on 6/7/14.
//  Copyright (c) 2014 Yung-Luen Lan. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton.buttonWithType(.Custom) as UIButton
    
        self.nextKeyboardButton.titleLabel.font = UIFont.systemFontOfSize(40)
        self.nextKeyboardButton.setTitle(NSLocalizedString("⊿", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
    
        self.nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.nextKeyboardButton)

        let nButton = UIButton.buttonWithType(.Custom) as UIButton
        nButton.setImage(UIImage(named: "nocchi"), forState: .Normal)
        nButton.setImage(UIImage(named: "nocchi-press"), forState: .Highlighted)
        nButton.setImage(UIImage(named: "nocchi-press"), forState: .Selected)
        nButton.sizeToFit()
        nButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(nButton)
        
        let aButton = UIButton.buttonWithType(.Custom) as UIButton
        aButton.setImage(UIImage(named: "achan"), forState: .Normal)
        aButton.setImage(UIImage(named: "achan-press"), forState: .Highlighted)
        aButton.setImage(UIImage(named: "achan-press"), forState: .Selected)
        aButton.sizeToFit()
        aButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(aButton)

        let kButton = UIButton.buttonWithType(.Custom) as UIButton
        kButton.setImage(UIImage(named: "yuka"), forState: .Normal)
        kButton.setImage(UIImage(named: "yuka-press"), forState: .Highlighted)
        kButton.setImage(UIImage(named: "yuka-press"), forState: .Selected)
        kButton.sizeToFit()
        kButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(kButton)

        let hConstrains = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(>=5)-[n(==a)]-[a]-[k(==a)]-(>=5)-|", options: nil, metrics: nil, views: ["n": nButton, "a": aButton, "k": kButton])
        let aTopContstraint = NSLayoutConstraint(item: aButton, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 10)
        let nTopContstraint = NSLayoutConstraint(item: nButton, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 10)
        let kTopContstraint = NSLayoutConstraint(item: kButton, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 10)
        self.view.addConstraints(hConstrains)
        self.view.addConstraints([aTopContstraint, nTopContstraint, kTopContstraint])
        
        var nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0)
        var nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        self.view.addConstraints([nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput) {
        // The app has just changed the document's contents, the document context has been updated.
    
        var textColor: UIColor
        var proxy = self.textDocumentProxy as UITextDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
        self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }

}
