//
//  ReleaseCollectVC.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-08-29.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit

class ReleaseCollectVC: UIViewController {

  @IBOutlet weak var initialTextField: UITextField!
  var personalInformation = NSMutableDictionary()
  var medicalInformation = NSMutableDictionary()
  var workInjuryInformation = NSMutableDictionary()
  var motorVehicleInjuryInformation = NSMutableDictionary()
  var healthCoverageInformation = NSMutableDictionary()
  var conditionsInformation = NSMutableDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: #selector(nextTapped))
        //self.navigationItem.hidesBackButton = true
        pageControl.hidden = true
        self.navigationItem.title = "Consent to Release and/or Collect Medical Information"

    }

    func nextTapped(){
      self.performSegueWithIdentifier("thankYou", sender: self)
    }
  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      var controller = SubmitScreenViewController()
      controller = segue.destinationViewController as! SubmitScreenViewController
      controller.personalInformation = personalInformation
      controller.medicalInformation = medicalInformation
      controller.workInjuryInformation = workInjuryInformation
      controller.motorVehicleInjuryInformation = motorVehicleInjuryInformation
      controller.healthCoverageInformation = healthCoverageInformation
      controller.conditionsInformation = conditionsInformation
    }
}
