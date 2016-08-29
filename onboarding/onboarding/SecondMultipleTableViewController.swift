//
//  SecondMultipleTableViewController.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-08-12.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit

var eyeEarNoseThroat = []
var eyeEarNoseThroatData = [String:[String:String]]()
var eyeEarNoseThroatDic = [String:String]()

var urinaryTract = []
var urinaryTractData = [String:[String:String]]()
var urinaryTractDic = [String:String]()

class SecondMultipleTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    var personalInformation = NSMutableDictionary()
    var medicalInformation = NSMutableDictionary()
    var workInjuryInformation = NSMutableDictionary()
    var motorVehicleInjuryInformation = NSMutableDictionary()
    var healthCoverageInformation = NSMutableDictionary()
    var conditionsInformation = NSMutableDictionary()

    let cellIdentifier = "Cell"
    let myColor : UIColor = UIColor( red: 0, green: 122/255, blue:255/255, alpha: 1.0)

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.navigationItem.title = "Other systems"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: #selector(nextTapped))
      
        eyeEarNoseThroat = ["Vision Problems","Hoarseness","Nose Bleeding","Ear Pain","Dental Problems","Hearing Loss","Store Throat","Ringing in Ear(s)"]
        urinaryTract = ["Blood in Urine","Bladder Infection","Inability to Control Urination"," Kidney Stones","Painful Urination"]
      
        for i in eyeEarNoseThroat{
          eyeEarNoseThroatDic = ["previously":"No","presently":"No","Selected":"No"]
          eyeEarNoseThroatData.updateValue(eyeEarNoseThroatDic, forKey: i as! String)
        }
      
        for i in urinaryTract{
          urinaryTractDic = ["previously":"No","presently":"No","Selected":"No"]
          urinaryTractData.updateValue(urinaryTractDic, forKey: i as! String)
        }
    }
  
    func nextTapped(){
      self.performSegueWithIdentifier("goToNeuro", sender: self)
    }
  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var controller = NeuromusculoskeletalTableViewController()
        controller = segue.destinationViewController as! NeuromusculoskeletalTableViewController
        controller.personalInformation = personalInformation
        controller.medicalInformation = medicalInformation
        controller.workInjuryInformation = workInjuryInformation
        controller.motorVehicleInjuryInformation = motorVehicleInjuryInformation
        controller.healthCoverageInformation = healthCoverageInformation
        controller.conditionsInformation = conditionsInformation
    }

    override func viewWillAppear(animated: Bool) {
      pageControl.currentPage = 5
    }
  
    override func viewWillDisappear(animated: Bool) {
      
      for cells in tableView.visibleCells{
        let cell = cells as! SecondMultipleTableViewCell
        //EYE EAR NOSE AND THROAT
        if(cell.circleButton.tag == 0 && cell.squareButton.tag == 0)
        {
          if(cell.circleButton.backgroundColor == myColor){
            eyeEarNoseThroatData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "previously")
          }
          else{
            eyeEarNoseThroatData[cell.titleLabel.text!]!.updateValue("No", forKey: "previously")
          }
          if(cell.squareButton.backgroundColor == myColor){
            eyeEarNoseThroatData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "presently")
          }
          else{
            eyeEarNoseThroatData[cell.titleLabel.text!]!.updateValue("No", forKey: "presently")
          }
        }
        
        //URINARY TRACT
        if(cell.circleButton.tag == 1 && cell.squareButton.tag == 1)
        {
          if(cell.circleButton.backgroundColor == myColor){
            urinaryTractData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "previously")
          }
          else{
            urinaryTractData[cell.titleLabel.text!]!.updateValue("No", forKey: "previously")
          }
          if(cell.squareButton.backgroundColor == myColor){
            urinaryTractData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "presently")
          }
          else{
            urinaryTractData[cell.titleLabel.text!]!.updateValue("No", forKey: "presently")
          }
        }
      }
    }

    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      
        return 3
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(section == 0)
        {
         return 0
        }
        if(section == 1){
          return eyeEarNoseThroat.count
        }
        else
        {
          return urinaryTract.count
        }
    }
  
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
      if(section == 0)
      {
        return "Please check: \(circleScalar) for previously had and \(squareScalar) for presently have"
      }
      if(section == 1)
      {
        return "Eye, Ear, Nose and Throat"
      }
      else
      {
       return "Urinary Tract"
      }
    }

  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
      let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SecondMultipleTableViewCell
      cell.selectionStyle = UITableViewCellSelectionStyle.None
      cell.contentView.userInteractionEnabled = false
      cell.circleButton.layer.borderWidth = 1
      cell.circleButton.layer.borderColor = myColor.CGColor
      cell.squareButton.layer.borderColor = myColor.CGColor

      if(indexPath.section == 1)
      {
        cell.titleLabel.text = eyeEarNoseThroat[indexPath.row] as? String
        cell.circleButton.tag = 0
        cell.squareButton.tag = 0
      }
      if(indexPath.section == 2)
      {
        cell.titleLabel.text = urinaryTract[indexPath.row] as? String
        cell.circleButton.tag = 1
        cell.squareButton.tag = 1
      }
      
      return cell
    }
}
