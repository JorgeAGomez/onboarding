//
//  SecondNeuroTableViewController.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-08-15.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit

var lowback = []
var lowDic = [String:String]()
var lowData = [String:[String:String]]()

var armshands = []
var armsDic = [String:String]()
var armsData = [String:[String:String]]()


class SecondNeuroTableViewController: UITableViewController{

    let cellIdentifier = "Cell"
    let myColor : UIColor = UIColor( red: 0, green: 122/255, blue:255/255, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        lowback = ["Low Back Pain","Low Back stiffness","Tailbone pain","Muscle Spasms","Pinched nerve"]
        armshands = ["Pain in elbow / arm","Pain in forearm","Pain in hands / fingers","Arthritis / swollen hands","Cold hands","Carpal Tunnel","Tingling in hands","Loss of grip strength"]
      
        for i in lowback
        {
          lowDic = ["previously":"No","presently":"No"]
          lowData.updateValue(lowDic, forKey: i as! String)
        }
      
        for i in armshands
        {
          armsDic = ["previously":"No","presently":"No"]
          armsData.updateValue(armsDic, forKey: i as! String)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    override func viewWillDisappear(animated: Bool) {
      for cells in tableView.visibleCells {
        let cell = cells as! PostCellTableViewCell

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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
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
  
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
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

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PostCellTableViewCell
      cell.selectionStyle = UITableViewCellSelectionStyle.None
      cell.contentView.userInteractionEnabled = false
      cell.circleButton.layer.borderWidth = 1
      cell.circleButton.layer.borderColor = myColor.CGColor
      cell.squareButton.layer.borderColor = myColor.CGColor
      
      
      if(indexPath.section == 1)
      {
        cell.titleLabel.text = lowback[indexPath.row] as? String
        cell.circleButton.tag = 0
        cell.squareButton.tag = 0
      }
      if(indexPath.section == 2)
      {
        cell.titleLabel.text = armshands[indexPath.row] as? String
        cell.circleButton.tag = 1
        cell.squareButton.tag = 1
      }
      return cell
    }

}
