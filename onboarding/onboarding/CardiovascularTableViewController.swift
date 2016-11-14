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
var cardiovascular:NSArray = []


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
      self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextTapped))
      
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
  
    override func viewWillAppear(_ animated: Bool) {
      pageControl.currentPage = 3
    }
  
    func nextTapped(){
      self.performSegue(withIdentifier: "goToMultiple", sender: self)
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      var controller = MultipleSectionsTableViewController()
      controller = segue.destination as! MultipleSectionsTableViewController
      controller.personalInformation = personalInformation
      controller.medicalInformation = medicalInformation
      controller.workInjuryInformation = workInjuryInformation
      controller.motorVehicleInjuryInformation = motorVehicleInjuryInformation
      controller.healthCoverageInformation = healthCoverageInformation
      controller.conditionsInformation = conditionsInformation
    }
  
    override func viewWillDisappear(_ animated: Bool)
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

    func numberOfSections(in tableView: UITableView) -> Int
    {
      return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
      return cardiovascular.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CardiovascularTableViewCell
      cell.selectionStyle = UITableViewCellSelectionStyle.none
      cell.titleLabel.text = cardiovascular[indexPath.row] as? String
      cell.circleButton.layer.borderColor = myColor.cgColor
      cell.squareButton.layer.borderColor = myColor.cgColor
      
            
      if(cardioData[cell.titleLabel.text!]!["previously"]! == "Yes"){
        cell.circleButton.backgroundColor = myColor
      }
      else{
        cell.circleButton.backgroundColor = UIColor.white
      }
      
      if(cardioData[cell.titleLabel.text!]!["presently"]! == "Yes"){
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
