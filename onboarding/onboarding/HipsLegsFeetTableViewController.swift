//
//  HipsLegsFeetTableViewController.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-08-15.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit

var hipsLegsFeet = []
var hipsDic = [String:String]()
var hipsData = [String:[String:String]]()

class HipsLegsFeetTableViewController: UITableViewController {

    let cellIdentifier = "Cell"
    let myColor : UIColor = UIColor( red: 0, green: 122/255, blue:255/255, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
      
        hipsLegsFeet = ["Pain in buttock","Pain in hip / knee joint","Cold feet","Tingling in feet","Arthritis","Sprain / strain","Pain down leg(s)","Tingling in leg(s)","Swollen ankle / feet","Pain in ankle / feet","Loss of leg strength","Muscles cramps"]
              
        for i in hipsLegsFeet
        {
          hipsDic = ["previously":"No","presently":"No"]
          hipsData.updateValue(hipsDic, forKey: i as! String)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    override func viewWillDisappear(animated: Bool) {
      for cells in tableView.visibleCells {
        let cell = cells as! PostCellTableViewCell

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
  
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section == 0){
          return 0
        }
        else{
          return hipsLegsFeet.count
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
        cell.titleLabel.text = hipsLegsFeet[indexPath.row] as? String
      }
        return cell
    }
  
    func buttonTapped(){
      self.navigationController!.performSegueWithIdentifier("gogo", sender: self)
    }
}
