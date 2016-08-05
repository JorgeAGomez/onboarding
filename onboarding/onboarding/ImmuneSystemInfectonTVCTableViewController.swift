//
//  ImmuneSystemInfectonTVCTableViewController.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-07-26.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit
import XLPagerTabStrip

var immuneDic = [String:String]()
var immuneData = [String:[String:String]]()
var immuneSystemInfection = []

class ImmuneSystemInfectonTVCTableViewController: UITableViewController, IndicatorInfoProvider {
  

    
    let cellIdentifier = "Cell"
    var blackTheme = false
    let myColor : UIColor = UIColor( red: 0, green: 122/255, blue:255/255, alpha: 1.0)
    var itemInfo = IndicatorInfo(title: "View")
  
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
      immuneSystemInfection = ["HIV (AIDS)","Pneumonia","Allergies / sinus troubles","Catch colds / flue easily","Rheumatoid Arthritis","Venereal Disease","Tuberculosis","Rheumatic Fever"]
      tableView.registerNib(UINib(nibName: "PostCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: cellIdentifier)
      for i in immuneSystemInfection
      {
        immuneDic = ["previously":"No","presently":"No"]
        immuneData.updateValue(immuneDic, forKey: i as! String)
      }

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

  
    override func viewWillDisappear(animated: Bool)
    {
      for cell in tableView.visibleCells{
      let cells = cell as! PostCellTableViewCell
      if(cells.circleButton.backgroundColor == myColor)
      {
        immuneData[cells.titleLabel.text!]!.updateValue("Yes", forKey: "previously")
      }
      else
      {
        immuneData[cells.titleLabel.text!]!.updateValue("No", forKey: "previously")
      }
        
      if(cells.squareButton.backgroundColor == myColor)
      {
        immuneData[cells.titleLabel.text!]!.updateValue("Yes", forKey: "presently")
      }
      else
      {
        immuneData[cells.titleLabel.text!]!.updateValue("No", forKey: "presently")
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
      return immuneSystemInfection.count
    }
  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
      let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PostCellTableViewCell
      cell.selectionStyle = UITableViewCellSelectionStyle.None
      cell.contentView.userInteractionEnabled = false
      cell.titleLabel.text = immuneSystemInfection[indexPath.row] as? String
      cell.circleButton.layer.borderWidth = 1
      cell.circleButton.layer.borderColor = myColor.CGColor
      cell.squareButton.layer.borderColor = myColor.CGColor
      return cell
    }
  
    // MARK: - IndicatorInfoProvider

    func indicatorInfoForPagerTabStrip(pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }


}
