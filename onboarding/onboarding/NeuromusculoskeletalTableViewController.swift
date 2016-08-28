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
var neuro = []

var headNeck = []
var headNeckDic = [String:String]()
var headNeckData = [String:[String:String]]()

var shoulder = []
var shoulderDic = [String:String]()
var shoulderData = [String:[String:String]]()

var midback = []
var midDic = [String:String]()
var midData = [String:[String:String]]()


class NeuromusculoskeletalTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier = "Cell"
    let myColor : UIColor = UIColor( red: 0, green: 122/255, blue:255/255, alpha: 1.0)
  
    override func viewDidLoad()
    {
        super.viewDidLoad()
      
        self.navigationItem.title = "Neuromusculoskeletal"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: #selector(nextTapped))

        headNeck = ["Headaches","Neck Pain / stiffness","Pinched nerve","Jaw Pain / TMJ","Arthritis in neck"]
        shoulder = ["Shoulder pain","Can't raise arm","Arthritis","Bursitis","Clicking / popping"]
        midback = ["Mid back Pain","Pain between shoulders","Muscle spasms","Sharp stabbing pain"]
      
        neuro = ["Headaches","Neck Pain / stiffness","Pinched nerve","Jaw Pain / TMJ","Arthritis in neck","Shoulder pain","Can't raise arm"," arthritis","Bursitis","Clicking / popping","Mid back Pain","Pain between shoulders","Muscle spasms","Sharp stabbing pain","Low Back Pain","Low Back stiffness","Tailbone pain","Muscle Spasms","Pinched nerve","Pain in elbow / arm","Pain in forearm","Pain in hands / fingers","Arthritis / swollen hands","Cold hands","Carpal Tunnel","Tingling in hands","Loss of grip strength","Pain in buttock","Pain in hip / knee joint","Cold feet","Tingling in feet","Arthritis","Sprain / strain","Pain down leg(s)","Tingling in leg(s)","Swollen ankle / feet","Pain in ankle / feet","Loss of leg strength","Muscles cramps"]

        for i in neuro
        {
          neuroDic = ["previously":"No","presently":"No"]
          neuroData.updateValue(neuroDic, forKey: i as! String)
        }

        for i in headNeck
        {
          headNeckDic = ["previously":"No","presently":"No"]
          headNeckData.updateValue(headNeckDic, forKey: i as! String)
        }

        for i in shoulder
        {
          shoulderDic = ["previously":"No","presently":"No"]
          shoulderData.updateValue(shoulderDic, forKey: i as! String)
        }
      
        for i in midback
        {
          midDic = ["previously":"No","presently":"No"]
          midData.updateValue(midDic, forKey: i as! String)
        }

    }
  
    func nextTapped(){
      self.performSegueWithIdentifier("goToNeuro2", sender: self)
    }
  
    override func viewWillAppear(animated: Bool) {
      pageControl.currentPage = 6
    }
  
  
    override func viewWillDisappear(animated: Bool) {
      for cells in tableView.visibleCells {
        let cell = cells as! PostCellTableViewCell
        
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
      self.performSegueWithIdentifier("go", sender: self)
    }


    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
  
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
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

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
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

  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PostCellTableViewCell
      
      cell.selectionStyle = UITableViewCellSelectionStyle.None
      cell.contentView.userInteractionEnabled = false
      cell.circleButton.layer.borderWidth = 1
      cell.circleButton.layer.borderColor = myColor.CGColor
      cell.squareButton.layer.borderColor = myColor.CGColor
      
      if(indexPath.section == 1)
      {
        cell.titleLabel.text = headNeck[indexPath.row] as? String
        cell.circleButton.tag = 0
        cell.squareButton.tag = 0
      }
      if(indexPath.section == 2)
      {
        cell.titleLabel.text = shoulder[indexPath.row] as? String
        cell.circleButton.tag = 1
        cell.squareButton.tag = 1
      }
      if(indexPath.section == 3)
      {
        cell.titleLabel.text = midback[indexPath.row] as? String
        cell.circleButton.tag = 2
        cell.squareButton.tag = 2
      }

      return cell
    }
 
}
