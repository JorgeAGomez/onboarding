//
//  AssessmentTreatmentVC.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-08-29.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit

class AssessmentTreatmentVC: UIViewController {

  @IBOutlet weak var paragraphLabel: UILabel!
  @IBOutlet weak var initialTextField: UITextField!
  var personalInformation = NSMutableDictionary()
  var medicalInformation = NSMutableDictionary()
  var workInjuryInformation = NSMutableDictionary()
  var motorVehicleInjuryInformation = NSMutableDictionary()
  var healthCoverageInformation = NSMutableDictionary()
  var conditionsInformation = NSMutableDictionary()
  var firstBoxInitials = String()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextTapped))
        self.navigationItem.hidesBackButton = true
        pageControl.isHidden = true
        self.navigationItem.title = "Consent to Assessment and Treatment"
        let firstName = personalInformation["First name"] as! String
        let lastName = personalInformation["Last name"] as! String
      
        let getText = paragraphLabel.text
        let nameAdded = getText!.replacingOccurrences(of: "_____________________________________", with: "\(firstName) \(lastName)")
      
        let font = UIFont(name: "Helvetica Neue", size: 16.0) ?? UIFont.systemFont(ofSize: 16.0)
        let textFont = [NSFontAttributeName:font]
        let theText = NSAttributedString(string: nameAdded, attributes: textFont)
        let newText = NSMutableAttributedString()
        newText.append(theText)
      

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacingBefore = 20.0
      
        newText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0,length: newText.length))
      
        paragraphLabel.attributedText = newText
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    func nextTapped(){
      firstBoxInitials = initialTextField.text!
      if(initialTextField.text == ""){
        let alert = UIAlertController(title: "Sorry", message: "Initials box cannot be empty", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
      self.present(alert, animated: true, completion: nil)
      }
      self.performSegue(withIdentifier: "goToConsent2", sender: self)
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      var controller = ReleaseCollectVC()
      controller = segue.destination as! ReleaseCollectVC
      controller.personalInformation = personalInformation
      controller.medicalInformation = medicalInformation
      controller.workInjuryInformation = workInjuryInformation
      controller.motorVehicleInjuryInformation = motorVehicleInjuryInformation
      controller.healthCoverageInformation = healthCoverageInformation
      controller.conditionsInformation = conditionsInformation
      controller.firstBoxInitials = firstBoxInitials
      
    }
  
  

}
