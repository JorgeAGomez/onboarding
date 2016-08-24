//
//  ConsentFirstPageViewController.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-07-29.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit



public class ConsentFirstPageViewController: UIViewController {
  
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = ""
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor.whiteColor()
        let newView = consentFirstScreenView()
        newView.frame = CGRect(x:90.0, y: 0.0, width: 600, height: 600)
        self.view.addSubview(newView)
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: #selector(nextTapped))
    }

    func nextTapped(){
      let controller = ConsentSecondPageViewController()
      self.showViewController(controller, sender: self)
    }
  
}
