//
//  SubmitScreenViewController.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-07-28.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit
import MessageUI
class SubmitScreenViewController: UIViewController, MFMailComposeViewControllerDelegate {

  @IBOutlet weak var submitButton: UIButton!
  
    override func viewDidLoad() {
      super.viewDidLoad()
        pageControl.hidesForSinglePage = true
        submitButton.layer.borderColor = submitButton.tintColor.CGColor
        self.navigationItem.hidesBackButton = true
      
    }

    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
    }
  
  @IBAction func submitButton(sender: AnyObject) {
    self.performSegueWithIdentifier("goBack", sender: self)
  }
  
    


}
