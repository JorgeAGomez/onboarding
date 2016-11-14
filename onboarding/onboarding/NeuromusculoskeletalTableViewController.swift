//
//  NeuromusculoskeletalTableViewController.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-07-26.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit

var neuroDic = [String:String]()
var neuroData = [String:[String:String]]()
var neuro:NSArray = []

var headNeck:NSArray = []
var headNeckDic = [String:String]()
var headNeckData = [String:[String:String]]()

var shoulder:NSArray = []
var shoulderDic = [String:String]()
var shoulderData = [String:[String:String]]()

var midback:NSArray = []
var midDic = [String:String]()
var midData = [String:[String:String]]()


class NeuromusculoskeletalTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    var personalInformation = NSMutableDictionary()
    var medicalInformation = NSMutableDictionary()
    var workInjuryInformation = NSMutableDictionary()
    var motorVehicleInjuryInformation = NSMutableDictionary()
    var healthCoverageInformation = NSMutableDictionary()
    var conditionsInformation = NSMutableDictionary()
    var noNo1 = true
    var noNo2 = true
    var noNo3 = true
  
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier = "Cell"
    let myColor : UIColor = UIColor( red: 0, green: 122/255, blue:255/255, alpha: 1.0)
  
    override func viewDidLoad()
    {
        super.viewDidLoad()
      
        self.navigationItem.title = "Neuromusculoskeletal"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextTapped))

        headNeck = ["Headaches","Neck Pain / stiffness","Pinched nerve","Jaw Pain / TMJ","Arthritis in neck"]
        shoulder = ["Shoulder pain","Can't raise arm","Arthritis","Bursitis","Clicking / popping"]
        midback = ["Mid back Pain","Pain between shoulders","Muscle spasms","Sharp stabbing pain"]
      
        neuro = ["Headaches","Neck Pain / stiffness","Pinched nerve","Jaw Pain / TMJ","Arthritis in neck","Shoulder pain","Can't raise arm"," arthritis","Bursitis","Clicking / popping","Mid back Pain","Pain between shoulders","Muscle spasms","Sharp stabbing pain","Low Back Pain","Low Back stiffness","Tailbone pain","Muscle Spasms","Pinched nerve","Pain in elbow / arm","Pain in forearm","Pain in hands / fingers","Arthritis / swollen hands","Cold hands","Carpal Tunnel","Tingling in hands","Loss of grip strength","Pain in buttock","Pain in hip / knee joint","Cold feet","Tingling in feet","Arthritis","Sprain / strain","Pain down leg(s)","Tingling in leg(s)","Swollen ankle / feet","Pain in ankle / feet","Loss of leg strength","Muscles cramps"]

      //HEADNECK
      for i in headNeckData{
        if(i.1["previously"] == "Yes" || i.1["presently"] == "Yes"){
          noNo1 = false
        }
        else{
          headNeckData.updateValue(["previously":"No","presently":"No"], forKey: i.0)
        }
      }
      if(noNo1){
        for i in headNeck
        {
          headNeckDic = ["previously":"No","presently":"No"]
          headNeckData.updateValue(headNeckDic, forKey: i as! String)
        }
      }
      
      //SHOULDER
      for i in shoulderData{
        if(i.1["previously"] == "Yes" || i.1["presently"] == "Yes"){
          noNo2 = false
        }
        else{
          shoulderData.updateValue(["previously":"No","presently":"No"], forKey: i.0)
        }
      }
      if(noNo2){
        for i in shoulder
        {
          shoulderDic = ["previously":"No","presently":"No"]
          shoulderData.updateValue(shoulderDic, forKey: i as! String)
        }
      }
      
      //MIDBACK
      for i in midData{
        if(i.1["previously"] == "Yes" || i.1["presently"] == "Yes"){
          noNo3 = false
        }
        else{
          midData.updateValue(["previously":"No","presently":"No"], forKey: i.0)
        }
      }
      if(noNo3){
        for i in midback
        {
          midDic = ["previously":"No","presently":"No"]
          midData.updateValue(midDic, forKey: i as! String)
        }
      }
      
    }
  
    func nextTapped(){
      self.performSegue(withIdentifier: "goToNeuro2", sender: self)
    }
  
    override func viewWillAppear(_ animated: Bool) {
      pageControl.currentPage = 6
    }
  
  
    override func viewWillDisappear(_ animated: Bool) {
      for cells in tableView.visibleCells {
        let cell = cells as! NeuroTableViewCell
        
        //HEAD NECK
        if(cell.circleButton.tag == 0 && cell.squareButton.tag == 0)
        {
            if(cell.circleButton.backgroundColor == myColor){
              headNeckData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "previously")
            }
            else{
              headNeckData[cell.titleLabel.text!]!.updateValue("No", forKey: "previously")
            }
            if(cell.squareButton.backgroundColor == myColor){
              headNeckData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "presently")
            }
            else{
              headNeckData[cell.titleLabel.text!]!.updateValue("No", forKey: "presently")
            }
        }
        
        //SHOULDER
        if(cell.circleButton.tag == 1 && cell.squareButton.tag == 1)
        {
            if(cell.circleButton.backgroundColor == myColor){
              shoulderData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "previously")
            }
            else{
              shoulderData[cell.titleLabel.text!]!.updateValue("No", forKey: "previously")
            }
            if(cell.squareButton.backgroundColor == myColor){
              shoulderData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "presently")
            }
            else{
              shoulderData[cell.titleLabel.text!]!.updateValue("No", forKey: "presently")
            }
        }
        
        //MID BACK
        if(cell.circleButton.tag == 2 && cell.squareButton.tag == 2)
        {
            if(cell.circleButton.backgroundColor == myColor){
              midData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "previously")
            }
            else{
              midData[cell.titleLabel.text!]!.updateValue("No", forKey: "previously")
            }
            if(cell.squareButton.backgroundColor == myColor){
              midData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "presently")
            }
            else{
              midData[cell.titleLabel.text!]!.updateValue("No", forKey: "presently")
            }
        }
        

      }
    }
  
    func sayHello()
    {
      self.performSegue(withIdentifier: "go", sender: self)
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      var controller = SecondNeuroTableViewController()
      controller = segue.destination as! SecondNeuroTableViewController
      controller.personalInformation = personalInformation
      controller.medicalInformation = medicalInformation
      controller.workInjuryInformation = workInjuryInformation
      controller.motorVehicleInjuryInformation = motorVehicleInjuryInformation
      controller.healthCoverageInformation = healthCoverageInformation
      controller.conditionsInformation = conditionsInformation
    }


    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
  
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
      if(section == 0)
      {
        return "Please check: \(circleScalar) for previously had and \(squareScalar) for presently have"
      }
      if(section == 1)
      {
        return "Head & Neck"
      }
      if(section == 2)
      {
       return "Shoulder"
      }
      else
      {
        return "Mid-Back"
      }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
      if(section == 0)
      {
        return 0
      }
      if(section == 1)
      {
        return headNeck.count
      }
      if(section == 2)
      {
        return shoulder.count
      }
      else
      {
        return midback.count
      }
    }

  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NeuroTableViewCell
      
      cell.selectionStyle = UITableViewCellSelectionStyle.none
      cell.circleButton.layer.borderColor = myColor.cgColor
      cell.squareButton.layer.borderColor = myColor.cgColor
      
      if(indexPath.section == 1)
      {
        cell.titleLabel.text = headNeck[indexPath.row] as? String
        cell.circleButton.tag = 0
        cell.squareButton.tag = 0
                
        if(headNeckData[cell.titleLabel.text!]!["previously"]! == "Yes"){
          cell.circleButton.backgroundColor = myColor
        }
        else{
          cell.circleButton.backgroundColor = UIColor.white
        }
        
        if(headNeckData[cell.titleLabel.text!]!["presently"]! == "Yes"){
          cell.squareButton.backgroundColor = myColor
        }
        else{
          cell.squareButton.backgroundColor = UIColor.white
        }
        
      }
      if(indexPath.section == 2)
      {
        cell.titleLabel.text = shoulder[indexPath.row] as? String
        cell.circleButton.tag = 1
        cell.squareButton.tag = 1
              
        if(shoulderData[cell.titleLabel.text!]!["previously"]! == "Yes"){
          cell.circleButton.backgroundColor = myColor
        }
        else{
          cell.circleButton.backgroundColor = UIColor.white
        }
        
        if(shoulderData[cell.titleLabel.text!]!["presently"]! == "Yes"){
          cell.squareButton.backgroundColor = myColor
        }
        else{
          cell.squareButton.backgroundColor = UIColor.white
        }
        
      }
      if(indexPath.section == 3)
      {
        cell.titleLabel.text = midback[indexPath.row] as? String
        cell.circleButton.tag = 2
        cell.squareButton.tag = 2
        
        if(midData[cell.titleLabel.text!]!["previously"]! == "Yes"){
          cell.circleButton.backgroundColor = myColor
        }
        else{
          cell.circleButton.backgroundColor = UIColor.white
        }
        
        if(midData[cell.titleLabel.text!]!["presently"]! == "Yes"){
          cell.squareButton.backgroundColor = myColor
        }
        else{
          cell.squareButton.backgroundColor = UIColor.white
        }
      }
      return cell
    }
 
}
