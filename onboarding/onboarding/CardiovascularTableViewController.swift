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
var cardiovascular = []


class CardiovascularTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier = "Cell"
    let myColor : UIColor = UIColor( red: 0, green: 122/255, blue:255/255, alpha: 1.0)

  
    override func viewDidLoad()
    {
      super.viewDidLoad()
      
      self.navigationItem.title = "Cardiovascular"
      self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: #selector(nextTapped))
      
      cardiovascular = ["Irregular Heartbeat","Stroke / Heart attack","Low Blood Pressure","High Blood Pressure","Palpitations","Swelling Ankles","Pain / Pressure in Chest","Shortness of Breath"]
      
      for i in cardiovascular
      {
        cardioDic = ["previously":"No","presently":"No"]
        cardioData.updateValue(cardioDic, forKey: i as! String)
      }
    }
  
    override func viewWillAppear(animated: Bool) {
      pageControl.currentPage = 3
    }
  
    func nextTapped(){
      self.performSegueWithIdentifier("goToMultiple", sender: self)
    }
  
    override func viewWillDisappear(animated: Bool)
    {
      for cells in tableView.visibleCells{
        let cell = cells as! CardiovascularTableViewCell
        if(cell.circleButton.backgroundColor == myColor){
          cardioData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "previously")
        }
        else{
          cardioData[cell.titleLabel.text!]!.updateValue("No", forKey: "presently")
        }
        if(cell.squareButton.backgroundColor == myColor){
          cardioData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "previously")
        }
        else{
          cardioData[cell.titleLabel.text!]!.updateValue("No", forKey: "presently")
        }
      }
    }
  
    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
      return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
      return cardiovascular.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CardiovascularTableViewCell
      cell.selectionStyle = UITableViewCellSelectionStyle.None
      cell.contentView.userInteractionEnabled = false
      cell.titleLabel.text = cardiovascular[indexPath.row] as? String
      cell.circleButton.layer.borderColor = myColor.CGColor
      cell.squareButton.layer.borderColor = myColor.CGColor

      return cell
    }
  
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "Please check: \(circleScalar) for previously had and \(squareScalar) for presently have"
    }
}
