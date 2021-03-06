//
//  SecondNeuroTableViewController.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-08-15.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit

var lowback:NSArray = []
var lowDic = [String:String]()
var lowData = [String:[String:String]]()

var armshands:NSArray = []
var armsDic = [String:String]()
var armsData = [String:[String:String]]()


class SecondNeuroTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
  
  var personalInformation = NSMutableDictionary()
  var medicalInformation = NSMutableDictionary()
  var workInjuryInformation = NSMutableDictionary()
  var motorVehicleInjuryInformation = NSMutableDictionary()
  var healthCoverageInformation = NSMutableDictionary()
  var conditionsInformation = NSMutableDictionary()
  var noNo1 = true
  var noNo2 = true
  
  @IBOutlet weak var tableView: UITableView!
    let cellIdentifier = "Cell"
    let myColor : UIColor = UIColor( red: 0, green: 122/255, blue:255/255, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Neuromusculoskeletal"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextTapped))
        lowback = ["Low Back Pain","Low Back stiffness","Tailbone pain","Muscle Spasms","Pinched nerve"]
        armshands = ["Pain in elbow / arm","Pain in forearm","Pain in hands / fingers","Arthritis / swollen hands","Cold hands","Carpal Tunnel","Tingling in hands","Loss of grip strength"]
      
        //LOWBACK
        for i in lowData{
        if(i.1["previously"] == "Yes" || i.1["presently"] == "Yes"){
          noNo1 = false
        }
        else{
          lowData.updateValue(["previously":"No","presently":"No"], forKey: i.0)
        }
      }
      if(noNo1){
        for i in lowback
        {
          lowDic = ["previously":"No","presently":"No"]
          lowData.updateValue(lowDic, forKey: i as! String)
        }
      }
      
      //ARMSHANDS
      for i in armsData{
        if(i.1["previously"] == "Yes" || i.1["presently"] == "Yes"){
          noNo2 = false
        }
        else{
          armsData.updateValue(["previously":"No","presently":"No"], forKey: i.0)
        }
      }
      if(noNo2){
        for i in armshands
        {
          armsDic = ["previously":"No","presently":"No"]
          armsData.updateValue(armsDic, forKey: i as! String)
        }
      }

    }
  
    func nextTapped(){
      self.performSegue(withIdentifier: "goToHips", sender: self)
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      var controller = HipsLegsFeetTableViewController()
      controller = segue.destination as! HipsLegsFeetTableViewController
      controller.personalInformation = personalInformation
      controller.medicalInformation = medicalInformation
      controller.workInjuryInformation = workInjuryInformation
      controller.motorVehicleInjuryInformation = motorVehicleInjuryInformation
      controller.healthCoverageInformation = healthCoverageInformation
      controller.conditionsInformation = conditionsInformation
    }

    override func viewWillAppear(_ animated: Bool) {
      pageControl.currentPage = 7
    }
  
    override func viewWillDisappear(_ animated: Bool) {
      for cells in tableView.visibleCells {
        let cell = cells as! SecondNeuroTableViewCell

        //LOW BACK
        if(cell.circleButton.tag == 0 && cell.squareButton.tag == 0)
        {
            if(cell.circleButton.backgroundColor == myColor){
              lowData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "previously")
            }
            else{
              lowData[cell.titleLabel.text!]!.updateValue("No", forKey: "previously")
            }
            if(cell.squareButton.backgroundColor == myColor){
              lowData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "presently")
            }
            else{
              lowData[cell.titleLabel.text!]!.updateValue("No", forKey: "presently")
            }
        }
        
        //ARMS HANDS
        if(cell.circleButton.tag == 1 && cell.squareButton.tag == 1)
        {
            if(cell.circleButton.backgroundColor == myColor){
              armsData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "previously")
            }
            else{
              armsData[cell.titleLabel.text!]!.updateValue("No", forKey: "previously")
            }
            if(cell.squareButton.backgroundColor == myColor){
              armsData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "presently")
            }
            else{
              armsData[cell.titleLabel.text!]!.updateValue("No", forKey: "presently")
            }
        }
      }
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
      if(section == 0)
      {
        return 0
      }
      if(section == 1)
      {
        return lowback.count
      }
      else
      {
        return armshands.count
      }
    }
  
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
      if(section == 0)
      {
        return "Please check: \(circleScalar) for previously had and \(squareScalar) for presently have"
      }
      if(section == 1)
      {
        return "Low-Back"
      }
      else
      {
        return "Arms & Hands"
      }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SecondNeuroTableViewCell
      cell.selectionStyle = UITableViewCellSelectionStyle.none
      cell.circleButton.layer.borderColor = myColor.cgColor
      cell.squareButton.layer.borderColor = myColor.cgColor
      
      
      if(indexPath.section == 1)
      {
        cell.titleLabel.text = lowback[indexPath.row] as? String
        cell.circleButton.tag = 0
        cell.squareButton.tag = 0
        
        if(lowData[cell.titleLabel.text!]!["previously"]! == "Yes"){
          cell.circleButton.backgroundColor = myColor
        }
        else{
          cell.circleButton.backgroundColor = UIColor.white
        }
        
        if(lowData[cell.titleLabel.text!]!["presently"]! == "Yes"){
          cell.squareButton.backgroundColor = myColor
        }
        else{
          cell.squareButton.backgroundColor = UIColor.white
        }

      }
      if(indexPath.section == 2)
      {
        cell.titleLabel.text = armshands[indexPath.row] as? String
        cell.circleButton.tag = 1
        cell.squareButton.tag = 1
        
        if(armsData[cell.titleLabel.text!]!["previously"]! == "Yes"){
          cell.circleButton.backgroundColor = myColor
        }
        else{
          cell.circleButton.backgroundColor = UIColor.white
        }
        
        if(armsData[cell.titleLabel.text!]!["presently"]! == "Yes"){
          cell.squareButton.backgroundColor = myColor
        }
        else{
          cell.squareButton.backgroundColor = UIColor.white
        }

      }
      return cell
    }

}
