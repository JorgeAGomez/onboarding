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
var immuneSystemInfection:NSArray = []


class ImmuneSystemViewController: UIViewController {

  var personalInformation = NSMutableDictionary()
  var medicalInformation = NSMutableDictionary()
  var workInjuryInformation = NSMutableDictionary()
  var motorVehicleInjuryInformation = NSMutableDictionary()
  var healthCoverageInformation = NSMutableDictionary()
  var conditionsInformation = NSMutableDictionary()
  var noNo = true
  
  @IBOutlet weak var tableView: UITableView!
    let cellIdentifier = "Cell"
    let myColor : UIColor = UIColor( red: 0, green: 122/255, blue:255/255, alpha: 1.0)
  
    override func viewDidLoad()
    {
      super.viewDidLoad()
      self.navigationItem.title = "Immune System / Infection"
      self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextTapped))
      
      immuneSystemInfection = ["HIV (AIDS)","Pneumonia","Allergies / sinus troubles","Catch colds / flue easily","Rheumatoid Arthritis","Venereal Disease","Tuberculosis","Rheumatic Fever"]
      for i in immuneData{
        if(i.1["previously"] == "Yes" || i.1["presently"] == "Yes"){
          noNo = false
        }
        else{
          immuneData.updateValue(["previously":"No","presently":"No"], forKey: i.0)
        }
      }
      if(noNo){
        for i in immuneSystemInfection
        {
          immuneDic = ["previously":"No","presently":"No"]
          immuneData.updateValue(immuneDic, forKey: i as! String)
        }
      }
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      var controller = GastrointestinalTableViewController()
      controller = segue.destination as! GastrointestinalTableViewController
      controller.personalInformation = personalInformation
      controller.medicalInformation = medicalInformation
      controller.workInjuryInformation = workInjuryInformation
      controller.motorVehicleInjuryInformation = motorVehicleInjuryInformation
      controller.healthCoverageInformation = healthCoverageInformation
      controller.conditionsInformation = conditionsInformation
    }

    func nextTapped(){
      self.performSegue(withIdentifier: "goToGastro", sender: self)
    }
  
    override func viewWillAppear(_ animated: Bool) {
      pageControl.currentPage = 1
    }

    override func viewWillDisappear(_ animated: Bool)
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

    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int
    {
      return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
      return immuneSystemInfection.count
    }
  
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell
    {
      let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ImmuneSystemTableViewCell
      cell.selectionStyle = UITableViewCellSelectionStyle.none
      cell.titleLabel.text = immuneSystemInfection[indexPath.row] as? String
      cell.circleButton.layer.borderColor = myColor.cgColor
      cell.squareButton.layer.borderColor = myColor.cgColor
      
      
      if(immuneData[cell.titleLabel.text!]!["previously"]! == "Yes"){
        cell.circleButton.backgroundColor = myColor
      }
      else{
        cell.circleButton.backgroundColor = UIColor.white
      }
      
      if(immuneData[cell.titleLabel.text!]!["presently"]! == "Yes"){
        cell.squareButton.backgroundColor = myColor
      }
      else{
        cell.squareButton.backgroundColor = UIColor.white
      }
      
      return cell
    }
  
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "Please check: \(circleScalar) for previously had and \(squareScalar) for presently have"
    }
  

}
