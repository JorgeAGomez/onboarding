//
//  MultipleSectionsTableViewController.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-07-26.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MultipleSectionsTableViewController: UITableViewController, IndicatorInfoProvider {

    var nervousSystem = []
    var respiratory = []
    var bloodSugar = []
    var eyeEarNoseThroat = []
    var urinaryTract = []
  
    let cellIdentifier = "Cell"
    var blackTheme = false
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
        nervousSystem = ["Dizziness / Lightheaded","Fainting","Discoordination","Memory Loss"]
        respiratory = ["Chronic Cough","Spitting Blood","Difficulty Breathing","Shortness of Breath","Asthma","Spitting up Phlegm","Emphysema"]
        bloodSugar = ["Irritable before Meals","Palpitations if miss meals","Gets shaky if hungry","Awaken from sleep"]
        eyeEarNoseThroat = ["Vision Problems","Hoarseness","Nose Bleeding","Ear Pain","Dental Problems","Hearing Loss","Store Throat","Ringing in Ear(s)"]
        urinaryTract = ["Blood in Urine","Bladder Infection","Inability to Control Urination"," Kidney Stones","Painful Urination"]
      
        tableView.registerNib(UINib(nibName: "PostCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: cellIdentifier)
        if blackTheme {
            tableView.backgroundColor = UIColor(red: 15/255.0, green: 16/255.0, blue: 16/255.0, alpha: 1.0)
          
        }

    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      
        return 5
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(section == 0)
        {
         return nervousSystem.count
        }
        if(section == 1)
        {
          return respiratory.count
        }
        if(section == 2)
        {
          return bloodSugar.count
        }
        if(section == 3)
        {
          return eyeEarNoseThroat.count
        }
        else
        {
          return urinaryTract.count
        }
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
      if(section == 0)
      {
        return "Nervous System"
      }
      if(section == 1)
      {
       return "Respiratory"
      }
      if(section == 2)
      {
        return "Blood Sugar"
      }
      if(section == 3)
      {
        return "Eye, Ear, Nose and Throat"
      }
      else
      {
        return "Urinary Tract"
      }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PostCellTableViewCell
      
      if(indexPath.section == 0)
      {
        cell.titleLabel.text = nervousSystem[indexPath.row] as? String
      }
      if(indexPath.section == 1)
      {
        cell.titleLabel.text = respiratory[indexPath.row] as? String
      }
      if(indexPath.section == 2)
      {
        cell.titleLabel.text = bloodSugar[indexPath.row] as? String
      }
      if(indexPath.section == 3)
      {
        cell.titleLabel.text = eyeEarNoseThroat[indexPath.row] as? String
      }
      if(indexPath.section == 4)
      {
        cell.titleLabel.text = urinaryTract[indexPath.row] as? String
      }
      return cell
    }
    
        // MARK: - IndicatorInfoProvider

    func indicatorInfoForPagerTabStrip(pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }

}
