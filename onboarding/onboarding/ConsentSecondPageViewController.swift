//
//  ConsentSecondPageViewController.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-08-24.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit

class ConsentSecondPageViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Patient Consent"
        //self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor.whiteColor()
        let newView = consentSecondScreenView()
        newView.initialsTextField.delegate = self
        newView.frame = CGRect(x:60.0, y: 0.0, width: 600, height: 600)
        self.view.addSubview(newView)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: #selector(nextTapped2))
      
    }
  
  
    func nextTapped2(){
      
    }
    
}
