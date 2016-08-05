//
//  GastrointestinalTableViewController.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-07-26.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit
import XLPagerTabStrip

var gastroDic = [String:String]()
var gastroData = [String:[String:String]]()
var gastrointestinal = []

class GastrointestinalTableViewController: UITableViewController,IndicatorInfoProvider {
  
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
      gastrointestinal = ["Gall Bladder Problem","Colitis","Blood in Stool","Constipation","Burning in Stomach","Heartburn","Excessive Thirst","Vomiting","Recent Weight Gain","Liver Trouble / Hepatitis","Mucus in Stool","Diarrhea","Pain over Stomach","Burping / Bloating","Distress from Greasy food","Nausea","Hiatal Hernia","Metallic taste","Recent Weight Loss"]
      tableView.registerNib(UINib(nibName: "PostCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: cellIdentifier)
      if blackTheme
      {
        tableView.backgroundColor = UIColor(red: 15/255.0, green: 16/255.0, blue: 16/255.0, alpha: 1.0)
      }
      
      for i in gastrointestinal
      {
        gastroDic = ["previously":"No","presently":"No"]
        gastroData.updateValue(gastroDic, forKey: i as! String)
      }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    override func viewWillDisappear(animated: Bool) {
     
      for cells in tableView.visibleCells
      {
        let cell = cells as! PostCellTableViewCell
        if(cell.circleButton.backgroundColor == myColor){
          gastroData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "previously")
        }
        else{
          gastroData[cell.titleLabel.text!]!.updateValue("No", forKey: "previously")
        }
        
        if(cell.squareButton.backgroundColor == myColor){
          gastroData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "presently")
        }
        else{
          gastroData[cell.titleLabel.text!]!.updateValue("No", forKey: "presently")
        }
      }
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return gastrointestinal.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PostCellTableViewCell
      cell.selectionStyle = UITableViewCellSelectionStyle.None
      cell.contentView.userInteractionEnabled = false
      cell.titleLabel.text = gastrointestinal[indexPath.row] as? String
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
