//
//  CardiovascularTableViewController.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-07-26.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit
import XLPagerTabStrip

var cardioDic = [String:String]()
var cardioData = [String:[String:String]]()
var cardiovascular = []


class CardiovascularTableViewController: UITableViewController,IndicatorInfoProvider {

    let cellIdentifier = "Cell"
    var blackTheme = false
    var itemInfo = IndicatorInfo(title: "View")
    let myColor : UIColor = UIColor( red: 0, green: 122/255, blue:255/255, alpha: 1.0)
  
    init(style: UITableViewStyle, itemInfo: IndicatorInfo)
    {
      self.itemInfo = itemInfo
      super.init(style: style)
    }
  
    required init?(coder aDecoder: NSCoder)
    {
      fatalError("init(coder:) has not been implemented")
    }

  
    override func viewDidLoad()
    {
      super.viewDidLoad()
      cardiovascular = ["Irregular Heartbeat","Stroke / Heart attack","Low Blood Pressure","High Blood Pressure","Palpitations","Swelling Ankles","Pain / Pressure in Chest","Shortness of Breath"]
      tableView.registerNib(UINib(nibName: "PostCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: cellIdentifier)
      if blackTheme
      {
        tableView.backgroundColor = UIColor(red: 15/255.0, green: 16/255.0, blue: 16/255.0, alpha: 1.0)
      }
      
      for i in cardiovascular
      {
        cardioDic = ["previously":"No","presently":"No"]
        cardioData.updateValue(cardioDic, forKey: i as! String)
      }
    }
  
    override func didReceiveMemoryWarning()
    {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
    }
  
    override func viewWillDisappear(animated: Bool)
    {
      for cells in tableView.visibleCells{
        let cell = cells as! PostCellTableViewCell
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
      return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
      return cardiovascular.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PostCellTableViewCell
      cell.selectionStyle = UITableViewCellSelectionStyle.None
      cell.contentView.userInteractionEnabled = false
      cell.titleLabel.text = cardiovascular[indexPath.row] as? String
      cell.circleButton.layer.borderWidth = 1
      cell.circleButton.layer.borderColor = myColor.CGColor
      cell.squareButton.layer.borderColor = myColor.CGColor

      return cell
    }
  
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "Please check: \(circleScalar) for previously had and \(squareScalar) for presently have"
    }
  
        // MARK: - IndicatorInfoProvider

    func indicatorInfoForPagerTabStrip(pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}
