//
//  SecondMultipleTableViewController.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-08-12.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit

var eyeEarNoseThroat:NSArray = []
var eyeEarNoseThroatData = [String:[String:String]]()
var eyeEarNoseThroatDic = [String:String]()

var urinaryTract:NSArray = []
var urinaryTractData = [String:[String:String]]()
var urinaryTractDic = [String:String]()

class SecondMultipleTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    var personalInformation = NSMutableDictionary()
    var medicalInformation = NSMutableDictionary()
    var workInjuryInformation = NSMutableDictionary()
    var motorVehicleInjuryInformation = NSMutableDictionary()
    var healthCoverageInformation = NSMutableDictionary()
    var conditionsInformation = NSMutableDictionary()
    var noNo1 = true
    var noNo2 = true
  

    let cellIdentifier = "Cell"
    let myColor : UIColor = UIColor( red: 0, green: 122/255, blue:255/255, alpha: 1.0)

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.navigationItem.title = "Other systems"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextTapped))
      
        eyeEarNoseThroat = ["Vision Problems","Hoarseness","Nose Bleeding","Ear Pain","Dental Problems","Hearing Loss","Store Throat","Ringing in Ear(s)"]
        urinaryTract = ["Blood in Urine","Bladder Infection","Inability to Control Urination"," Kidney Stones","Painful Urination"]
      
      for i in eyeEarNoseThroatData{
        if(i.1["previously"] == "Yes" || i.1["presently"] == "Yes"){
          noNo1 = false
        }
        else{
          eyeEarNoseThroatData.updateValue(["previously":"No","presently":"No"], forKey: i.0)
        }
      }
      if(noNo1){
        for i in eyeEarNoseThroat
        {
          eyeEarNoseThroatDic = ["previously":"No","presently":"No"]
          eyeEarNoseThroatData.updateValue(eyeEarNoseThroatDic, forKey: i as! String)
        }
      }
      
      for i in urinaryTractData{
        if(i.1["previously"] == "Yes" || i.1["presently"] == "Yes"){
          noNo2 = false
        }
        else{
          urinaryTractData.updateValue(["previously":"No","presently":"No"], forKey: i.0)
        }
      }
      if(noNo2){
        for i in urinaryTract
        {
          urinaryTractDic = ["previously":"No","presently":"No"]
          urinaryTractData.updateValue(urinaryTractDic, forKey: i as! String)
        }
      }
    
    }
  
    func nextTapped(){
      self.performSegue(withIdentifier: "goToNeuro", sender: self)
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var controller = NeuromusculoskeletalTableViewController()
        controller = segue.destination as! NeuromusculoskeletalTableViewController
        controller.personalInformation = personalInformation
        controller.medicalInformation = medicalInformation
        controller.workInjuryInformation = workInjuryInformation
        controller.motorVehicleInjuryInformation = motorVehicleInjuryInformation
        controller.healthCoverageInformation = healthCoverageInformation
        controller.conditionsInformation = conditionsInformation
    }

    override func viewWillAppear(_ animated: Bool) {
      pageControl.currentPage = 5
    }
  
    override func viewWillDisappear(_ animated: Bool) {
      
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
    func numberOfSections(in tableView: UITableView) -> Int {
      
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
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
  
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
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

  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SecondMultipleTableViewCell
      cell.selectionStyle = UITableViewCellSelectionStyle.none
      cell.circleButton.layer.borderColor = myColor.cgColor
      cell.squareButton.layer.borderColor = myColor.cgColor

      if(indexPath.section == 1)
      {
        cell.titleLabel.text = eyeEarNoseThroat[indexPath.row] as? String
        cell.circleButton.tag = 0
        cell.squareButton.tag = 0
        
        if(eyeEarNoseThroatData[cell.titleLabel.text!]!["previously"]! == "Yes"){
          cell.circleButton.backgroundColor = myColor
        }
        else{
          cell.circleButton.backgroundColor = UIColor.white
        }
        
        if(eyeEarNoseThroatData[cell.titleLabel.text!]!["presently"]! == "Yes"){
          cell.squareButton.backgroundColor = myColor
        }
        else{
          cell.squareButton.backgroundColor = UIColor.white
        }

      }
      if(indexPath.section == 2)
      {
        cell.titleLabel.text = urinaryTract[indexPath.row] as? String
        cell.circleButton.tag = 1
        cell.squareButton.tag = 1
        
        if(urinaryTractData[cell.titleLabel.text!]!["previously"]! == "Yes"){
          cell.circleButton.backgroundColor = myColor
        }
        else{
          cell.circleButton.backgroundColor = UIColor.white
        }
        
        if(urinaryTractData[cell.titleLabel.text!]!["presently"]! == "Yes"){
          cell.squareButton.backgroundColor = myColor
        }
        else{
          cell.squareButton.backgroundColor = UIColor.white
        }
        
      }
      
      return cell
    }
}
