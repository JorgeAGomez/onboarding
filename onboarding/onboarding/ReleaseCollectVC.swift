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
  var firstBoxInitials = String()
  var secondBoxInitials = String()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextTapped))
        //self.navigationItem.hidesBackButton = true
        pageControl.isHidden = true
        self.navigationItem.title = "Consent to Release and/or Collect Medical Information"
      
    }

    func nextTapped(){
      secondBoxInitials = initialTextField.text!
//      if(firstBoxInitials != secondBoxInitials)
//      {
//        let alert = UIAlertController(title: "Sorry", message: "All initials must match", preferredStyle: UIAlertControllerStyle.Alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
//        self.presentViewController(alert, animated: true, completion: nil)
//      }
//      
//      if(initialTextField.text == ""){
//        let alert = UIAlertController(title: "Sorry", message: "Initials box cannot be empty", preferredStyle: UIAlertControllerStyle.Alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
//      self.presentViewController(alert, animated: true, completion: nil)
//      }
      self.performSegue(withIdentifier: "thankYou", sender: self)
    }
  
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      var controller = SubmitScreenViewController()
      controller = segue.destination as! SubmitScreenViewController
      controller.personalInformation = personalInformation
      controller.medicalInformation = medicalInformation
      controller.workInjuryInformation = workInjuryInformation
      controller.motorVehicleInjuryInformation = motorVehicleInjuryInformation
      controller.healthCoverageInformation = healthCoverageInformation
      controller.conditionsInformation = conditionsInformation
      controller.firstBoxInitials = firstBoxInitials
      controller.secondBoxInitials = secondBoxInitials
    }
}
