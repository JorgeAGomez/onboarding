//
//  GeneralTableViewController.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-07-25.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit
import XLPagerTabStrip

var generalDic = [String:String]()
var dic1 = [String:[String:String]]()
var general = []

class GeneralTableViewController: UITableViewController, IndicatorInfoProvider {

    let cellIdentifier = "Cell"
    var blackTheme = false
    var itemInfo = IndicatorInfo(title: "View")
    let myColor : UIColor = UIColor( red: 0, green: 122/255, blue:255/255, alpha: 1.0)

    init(title: String, style: UITableViewStyle, itemInfo: IndicatorInfo)
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
      general = ["Diabetes","Hypoglycemia","Stress / Depression","Epilepsy / Seizures", "Skin conditions / Rashes","Alcoholism","High Cholesterol","Parkinson's disease","Heart disease","Cancer","Osteoarthritis","Ulcers","Anemia / Fatigue", "Multiple Sclerosis","Thyroid","Osteoporosis"]

      for i in general
      {
        generalDic = ["previously":"No","presently":"No"]
        dic1.updateValue(generalDic, forKey: i as! String)
      }
      
      tableView.registerNib(UINib(nibName: "PostCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: cellIdentifier)
      tableView.allowsMultipleSelection = true
      if blackTheme
      {
        tableView.backgroundColor = UIColor(red: 15/255.0, green: 16/255.0, blue: 16/255.0, alpha: 1.0)
      }
    }
  
    override func viewDidAppear(animated: Bool) {
      
      let newB = UIBarButtonItem()
      newB.title = "NewTitle"
      self.navigationItem.rightBarButtonItem = newB
    }

    override func didReceiveMemoryWarning()
    {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
    }
  
    override func viewWillDisappear(animated: Bool) {
      let table = tableView
     for cell in table.visibleCells {
        let cells = cell as! PostCellTableViewCell
        if(cells.circleButton.backgroundColor == myColor)
        {
          dic1[cells.titleLabel.text!]!.updateValue("Yes", forKey: "previously")
        }
        else
        {
          dic1[cells.titleLabel.text!]!.updateValue("No", forKey: "previously")
        }
        if(cells.squareButton.backgroundColor == myColor)
        {
          dic1[cells.titleLabel.text!]!.updateValue("Yes", forKey: "presently")
        }
        else
        {
          dic1[cells.titleLabel.text!]!.updateValue("No", forKey: "presently")
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
        return general.count
    }
  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
      let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PostCellTableViewCell
      cell.selectionStyle = UITableViewCellSelectionStyle.None
      cell.contentView.userInteractionEnabled = false
      cell.titleLabel.text = general[indexPath.row] as? String
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
