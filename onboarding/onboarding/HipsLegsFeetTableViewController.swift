//
//  HipsLegsFeetTableViewController.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-08-15.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit

var hipsLegsFeet:NSArray = []
var hipsDic = [String:String]()
var hipsData = [String:[String:String]]()

class HipsLegsFeetTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

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

    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.navigationItem.title = "Hips, Legs & Feet"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextTapped))
      
        hipsLegsFeet = ["Pain in buttock","Pain in hip / knee joint","Cold feet","Tingling in feet","Arthritis","Sprain / strain","Pain down leg(s)","Tingling in leg(s)","Swollen ankle / feet","Pain in ankle / feet","Loss of leg strength","Muscles cramps"]
              
        for i in hipsData{
          if(i.1["previously"] == "Yes" || i.1["presently"] == "Yes"){
            noNo = false
          }
          else{
            hipsData.updateValue(["previously":"No","presently":"No"], forKey: i.0)
          }
        }
        if(noNo){
          for i in hipsLegsFeet
          {
            hipsDic = ["previously":"No","presently":"No"]
            hipsData.updateValue(hipsDic, forKey: i as! String)
          }
        }
    }

    func nextTapped(){
      self.performSegue(withIdentifier: "goToConsent1", sender: self)
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      var controller = AssessmentTreatmentVC()
      controller = segue.destination as! AssessmentTreatmentVC
      controller.personalInformation = personalInformation
      controller.medicalInformation = medicalInformation
      controller.workInjuryInformation = workInjuryInformation
      controller.motorVehicleInjuryInformation = motorVehicleInjuryInformation
      controller.healthCoverageInformation = healthCoverageInformation
      controller.conditionsInformation = conditionsInformation
    }
  
    override func viewWillAppear(_ animated: Bool) {
      pageControl.currentPage = 8
    }
  
    override func viewWillDisappear(_ animated: Bool) {
      for cells in tableView.visibleCells {
        let cell = cells as! HipsLegsFeetTableViewCell

        //HIPS LEGS FEET
        if(cell.circleButton.backgroundColor == myColor){
          hipsData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "previously")
        }
        else{
          hipsData[cell.titleLabel.text!]!.updateValue("No", forKey: "previously")
        }
        if(cell.squareButton.backgroundColor == myColor){
          hipsData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "presently")
        }
        else{
          hipsData[cell.titleLabel.text!]!.updateValue("No", forKey: "presently")
        }
      }
    }
  
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
      if(section == 0)
      {
        return "Please check: \(circleScalar) for previously had and \(squareScalar) for presently have"
      }
      else
      {
        return "Hips, Legs & Feet"
      }
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section == 0){
          return 0
        }
        else{
          return hipsLegsFeet.count
        }
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HipsLegsFeetTableViewCell
      cell.selectionStyle = UITableViewCellSelectionStyle.none
      cell.circleButton.layer.borderColor = myColor.cgColor
      cell.squareButton.layer.borderColor = myColor.cgColor
      
      if(indexPath.section == 1)
      {
        cell.titleLabel.text = hipsLegsFeet[indexPath.row] as? String
        
        if(hipsData[cell.titleLabel.text!]!["previously"]! == "Yes"){
          cell.circleButton.backgroundColor = myColor
        }
        else{
          cell.circleButton.backgroundColor = UIColor.white
        }
        
        if(hipsData[cell.titleLabel.text!]!["presently"]! == "Yes"){
          cell.squareButton.backgroundColor = myColor
        }
        else{
          cell.squareButton.backgroundColor = UIColor.white
        }

        
      }
        return cell
    }
}
