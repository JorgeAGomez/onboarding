//
//  ImmuneSystemInfectonTVCTableViewController.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-07-26.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit


var immuneDic = [String:String]()
var immuneData = [String:[String:String]]()
var immuneSystemInfection = []


class ImmuneSystemViewController: UIViewController {

  var personalInformation = NSMutableDictionary()
  var medicalInformation = NSMutableDictionary()
  var workInjuryInformation = NSMutableDictionary()
  var motorVehicleInjuryInformation = NSMutableDictionary()
  var healthCoverageInformation = NSMutableDictionary()
  var conditionsInformation = NSMutableDictionary()
  
  @IBOutlet weak var tableView: UITableView!
    let cellIdentifier = "Cell"
    let myColor : UIColor = UIColor( red: 0, green: 122/255, blue:255/255, alpha: 1.0)
  
    override func viewDidLoad()
    {
      super.viewDidLoad()
      self.navigationItem.title = "Immune System / Infection"
      self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: #selector(nextTapped))
      
      immuneSystemInfection = ["HIV (AIDS)","Pneumonia","Allergies / sinus troubles","Catch colds / flue easily","Rheumatoid Arthritis","Venereal Disease","Tuberculosis","Rheumatic Fever"]
      for i in immuneSystemInfection
      {
        immuneDic = ["previously":"No","presently":"No"]
        immuneData.updateValue(immuneDic, forKey: i as! String)
      }

    }
  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      var controller = GastrointestinalTableViewController()
      controller = segue.destinationViewController as! GastrointestinalTableViewController
      controller.personalInformation = personalInformation
      controller.medicalInformation = medicalInformation
      controller.workInjuryInformation = workInjuryInformation
      controller.motorVehicleInjuryInformation = motorVehicleInjuryInformation
      controller.healthCoverageInformation = healthCoverageInformation
      controller.conditionsInformation = conditionsInformation
    }

    func nextTapped(){
      self.performSegueWithIdentifier("goToGastro", sender: self)
    }
  
    override func viewWillAppear(animated: Bool) {
      pageControl.currentPage = 1
    }

    override func viewWillDisappear(animated: Bool)
    {
      for cell in tableView.visibleCells{
      let cells = cell as! ImmuneSystemTableViewCell
      if(cells.circleButton.backgroundColor == myColor)
      {
        immuneData[cells.titleLabel.text!]!.updateValue("Yes", forKey: "previously")
      }
      else
      {
        immuneData[cells.titleLabel.text!]!.updateValue("No", forKey: "previously")
      }
        
      if(cells.squareButton.backgroundColor == myColor)
      {
        immuneData[cells.titleLabel.text!]!.updateValue("Yes", forKey: "presently")
      }
      else
      {
        immuneData[cells.titleLabel.text!]!.updateValue("No", forKey: "presently")
      }
        
      }
    }
  
    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
      return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
      return immuneSystemInfection.count
    }
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
      let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ImmuneSystemTableViewCell
      cell.selectionStyle = UITableViewCellSelectionStyle.None
      cell.contentView.userInteractionEnabled = false
      cell.titleLabel.text = immuneSystemInfection[indexPath.row] as? String
      cell.circleButton.layer.borderColor = myColor.CGColor
      cell.squareButton.layer.borderColor = myColor.CGColor
      return cell
    }
  
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "Please check: \(circleScalar) for previously had and \(squareScalar) for presently have"
    }
  

}
