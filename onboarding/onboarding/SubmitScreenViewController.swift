//
//  SubmitScreenViewController.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-07-28.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit

class SubmitScreenViewController: UIViewController {

    override func viewDidLoad() {
      super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
    }
  
  @IBAction func submitButton(sender: AnyObject)
  {
    
    
  
    // Create the alert controller
    let alertController = UIAlertController(title: "Thank you", message: "Please return iPad to the main desk", preferredStyle: .Alert)

    // Create the actions
    
    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
        UIAlertAction in
        self.performSegueWithIdentifier("goBack", sender: self)
    }

    // Add the actions
    alertController.addAction(okAction)

    // Present the controller
    self.presentViewController(alertController, animated: true, completion: nil)
  }
  

}
