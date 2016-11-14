//
//  GastrointestinalTableViewController.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-07-26.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit

var gastroDic = [String:String]()
var gastroData = [String:[String:String]]()
var gastrointestinal:NSArray = []


class GastrointestinalTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

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
      self.navigationItem.title = "Gastrointestinal"
      self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextTapped))
  
      gastrointestinal = ["Gall Bladder Problem","Colitis","Blood in Stool","Constipation","Burning in Stomach","Heartburn","Excessive Thirst","Vomiting","Recent Weight Gain","Liver Trouble / Hepatitis","Mucus in Stool","Diarrhea","Pain over Stomach","Burping / Bloating","Distress from Greasy food","Nausea","Hiatal Hernia","Metallic taste","Recent Weight Loss"]
      
      
      for i in gastroData{
        if(i.1["previously"] == "Yes" || i.1["presently"] == "Yes"){
          noNo = false
        }
        else{
          gastroData.updateValue(["previously":"No","presently":"No"], forKey: i.0)
        }
      }
      if(noNo){
        for i in gastrointestinal
        {
          gastroDic = ["previously":"No","presently":"No"]
          gastroData.updateValue(gastroDic, forKey: i as! String)
        }
      }
    }
  
    override func viewWillAppear(_ animated: Bool) {
      pageControl.currentPage = 2
    }

    func nextTapped(){
      self.performSegue(withIdentifier: "goToCardio", sender: self)
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      var controller = CardiovascularTableViewController()
      controller = segue.destination as! CardiovascularTableViewController
      controller.personalInformation = personalInformation
      controller.medicalInformation = medicalInformation
      controller.workInjuryInformation = workInjuryInformation
      controller.motorVehicleInjuryInformation = motorVehicleInjuryInformation
      controller.healthCoverageInformation = healthCoverageInformation
      controller.conditionsInformation = conditionsInformation
    }
  
    override func viewWillDisappear(_ animated: Bool) {
     
      for cells in tableView.visibleCells
      {
        let cell = cells as! GastrointestinalTableViewCell
        if(cell.circleButton.backgroundColor == myColor){
          gastroData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "previously")
        }
        else{
          gastroData[cell.titleLabel.text!]!.updateValue("No", forKey: "previously")
        }
        
        if(cell.squareButton.backgroundColor == myColor){
          gastroData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "presently")
        }
        else{
          gastroData[cell.titleLabel.text!]!.updateValue("No", forKey: "presently")
        }
      }
    }


    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return gastrointestinal.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! GastrointestinalTableViewCell
      cell.selectionStyle = UITableViewCellSelectionStyle.none
      cell.titleLabel.text = gastrointestinal[indexPath.row] as? String
      cell.circleButton.layer.borderColor = myColor.cgColor
      cell.squareButton.layer.borderColor = myColor.cgColor
      
            
      if(gastroData[cell.titleLabel.text!]!["previously"]! == "Yes"){
        cell.circleButton.backgroundColor = myColor
      }
      else{
        cell.circleButton.backgroundColor = UIColor.white
      }
      
      if(gastroData[cell.titleLabel.text!]!["presently"]! == "Yes"){
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
