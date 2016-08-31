//
//  CardiovascularTableViewController.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-07-26.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit

var cardioDic = [String:String]()
var cardioData = [String:[String:String]]()
var cardiovascular = []


class CardiovascularTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    var personalInformation = NSMutableDictionary()
    var medicalInformation = NSMutableDictionary()
    var workInjuryInformation = NSMutableDictionary()
    var motorVehicleInjuryInformation = NSMutableDictionary()
    var healthCoverageInformation = NSMutableDictionary()
    var conditionsInformation = NSMutableDictionary()
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier = "Cell"
    let myColor : UIColor = UIColor( red: 0, green: 122/255, blue:255/255, alpha: 1.0)
    var noNo = true
  
    override func viewDidLoad()
    {
      super.viewDidLoad()
      
      self.navigationItem.title = "Cardiovascular"
      self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: #selector(nextTapped))
      
      cardiovascular = ["Irregular Heartbeat","Stroke / Heart attack","Low Blood Pressure","High Blood Pressure","Palpitations","Swelling Ankles","Pain / Pressure in Chest","Shortness of Breath"]
      
      
      for i in cardioData{
        if(i.1["previously"] == "Yes" || i.1["presently"] == "Yes"){
          noNo = false
        }
        else{
          cardioData.updateValue(["previously":"No","presently":"No"], forKey: i.0)
        }
      }
      if(noNo){
        for i in cardiovascular
        {
          cardioDic = ["previously":"No","presently":"No"]
          cardioData.updateValue(cardioDic, forKey: i as! String)
        }
      }
    
    }
  
    override func viewWillAppear(animated: Bool) {
      pageControl.currentPage = 3
    }
  
    func nextTapped(){
      self.performSegueWithIdentifier("goToMultiple", sender: self)
    }
  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      var controller = MultipleSectionsTableViewController()
      controller = segue.destinationViewController as! MultipleSectionsTableViewController
      controller.personalInformation = personalInformation
      controller.medicalInformation = medicalInformation
      controller.workInjuryInformation = workInjuryInformation
      controller.motorVehicleInjuryInformation = motorVehicleInjuryInformation
      controller.healthCoverageInformation = healthCoverageInformation
      controller.conditionsInformation = conditionsInformation
    }
  
    override func viewWillDisappear(animated: Bool)
    {
      for cells in tableView.visibleCells{
        let cell = cells as! CardiovascularTableViewCell
        if(cell.circleButton.backgroundColor == myColor){
          cardioData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "previously")
        }
        else{
          cardioData[cell.titleLabel.text!]!.updateValue("No", forKey: "previously")
        }
        if(cell.squareButton.backgroundColor == myColor){
          cardioData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "presently")
        }
        else{
          cardioData[cell.titleLabel.text!]!.updateValue("No", forKey: "presently")
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
      return cardiovascular.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CardiovascularTableViewCell
      cell.selectionStyle = UITableViewCellSelectionStyle.None
      cell.titleLabel.text = cardiovascular[indexPath.row] as? String
      cell.circleButton.layer.borderColor = myColor.CGColor
      cell.squareButton.layer.borderColor = myColor.CGColor
      
            
      if(cardioData[cell.titleLabel.text!]!["previously"]! == "Yes"){
        cell.circleButton.backgroundColor = myColor
      }
      else{
        cell.circleButton.backgroundColor = UIColor.whiteColor()
      }
      
      if(cardioData[cell.titleLabel.text!]!["presently"]! == "Yes"){
        cell.squareButton.backgroundColor = myColor
      }
      else{
        cell.squareButton.backgroundColor = UIColor.whiteColor()
      }


      return cell
    }
  
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "Please check: \(circleScalar) for previously had and \(squareScalar) for presently have"
    }
}
