//
//  MultipleSectionsTableViewController.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-07-26.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit
import XLPagerTabStrip

var multipleDic = [String:String]()
var multipleData = [String:[String:String]]()
var multiple = []

var nervousSystem = []
var nervousData = [String:[String:String]]()
var nervousDic = [String:String]()

var respiratory = []
var respiratoryData = [String:[String:String]]()
var respiratoryDic = [String:String]()


var bloodSugar = []
var bloodSugarData = [String:[String:String]]()
var bloodSugarDic = [String:String]()


class MultipleSectionsTableViewController: UITableViewController, IndicatorInfoProvider {
  
    let cellIdentifier = "Multiple"
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
        nervousSystem = ["Dizziness / Lightheaded","Fainting","Discoordination","Memory Loss"]
        respiratory = ["Chronic Cough","Spitting Blood","Difficulty Breathing","Shortness of Breath","Asthma","Spitting up Phlegm","Emphysema"]
        bloodSugar = ["Irritable before Meals","Palpitations if miss meals","Gets shaky if hungry","Awaken from sleep"]
        
      
        multiple = ["Dizziness / Lightheaded","Fainting","Discoordination","Memory Loss","Chronic Cough","Spitting Blood","Difficulty Breathing","Shortness of Breath","Asthma","Spitting up Phlegm","Emphysema","Irritable before Meals","Palpitations if miss meals","Gets shaky if hungry","Awaken from sleep","Vision Problems","Hoarseness","Nose Bleeding","Ear Pain","Dental Problems","Hearing Loss","Store Throat","Ringing in Ear(s)","Blood in Urine","Bladder Infection","Inability to Control Urination"," Kidney Stones","Painful Urination"]
      
        tableView.registerNib(UINib(nibName: "PostCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: cellIdentifier)
        if blackTheme {
            tableView.backgroundColor = UIColor(red: 15/255.0, green: 16/255.0, blue: 16/255.0, alpha: 1.0)
          
        }
      
        for i in multiple{
          multipleDic = ["previously":"No","presently":"No"]
          multipleData.updateValue(multipleDic, forKey: i as! String)
        }
      
      
        for i in nervousSystem{
          nervousDic = ["previously":"No","presently":"No"]
          nervousData.updateValue(nervousDic, forKey: i as! String)
        }
      
        for i in respiratory{
          respiratoryDic = ["previously":"No","presently":"No"]
          respiratoryData.updateValue(respiratoryDic, forKey: i as! String)
        }
      
        for i in bloodSugar{
          bloodSugarDic = ["previously":"No","presently":"No"]
          bloodSugarData.updateValue(bloodSugarDic, forKey: i as! String)
        }

    }
  
    override func viewWillDisappear(animated: Bool)
    {
      for cells in tableView.visibleCells{
        let cell = cells as! PostCellTableViewCell
        
        //NERVOUS
        if(cell.circleButton.tag == 0 && cell.squareButton.tag == 0)
        {
          if(cell.circleButton.backgroundColor == myColor){
            nervousData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "previously")
          }
          else{
            nervousData[cell.titleLabel.text!]!.updateValue("No", forKey: "previously")
          }
          if(cell.squareButton.backgroundColor == myColor){
            nervousData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "presently")
          }
          else{
            nervousData[cell.titleLabel.text!]!.updateValue("No", forKey: "presently")
          }
        }
        
        //RESPIRATORY
        if(cell.circleButton.tag == 1 && cell.squareButton.tag == 1)
        {
          if(cell.circleButton.backgroundColor == myColor){
            respiratoryData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "previously")
          }
          else{
            respiratoryData[cell.titleLabel.text!]!.updateValue("No", forKey: "previously")
          }
          if(cell.squareButton.backgroundColor == myColor){
            respiratoryData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "presently")
          }
          else{
            respiratoryData[cell.titleLabel.text!]!.updateValue("No", forKey: "presently")
          }
        }
        
        //BLOOD SUGAR
        if(cell.circleButton.tag == 2 && cell.squareButton.tag == 2)
        {
          if(cell.circleButton.backgroundColor == myColor){
            bloodSugarData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "previously")
          }
          else{
            bloodSugarData[cell.titleLabel.text!]!.updateValue("No", forKey: "previously")
          }
          if(cell.squareButton.backgroundColor == myColor){
            bloodSugarData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "presently")
          }
          else{
            bloodSugarData[cell.titleLabel.text!]!.updateValue("No", forKey: "presently")
          }
        }
      }
    }
  
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(section == 0)
        {
         return 0
        }
        if(section == 1 )
        {
          return nervousSystem.count
        }
        if(section == 2)
        {
          return respiratory.count
        }
        else
        {
          return bloodSugar.count
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
        return "Nervous System"
      }
      if(section == 2)
      {
       return "Respiratory"
      }
      else
      {
        return "Blood Sugar"
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
        cell.titleLabel.text = nervousSystem[indexPath.row] as? String
        cell.circleButton.tag = 0
        cell.squareButton.tag = 0
      }
      if(indexPath.section == 2)
      {
        cell.titleLabel.text = respiratory[indexPath.row] as? String
        cell.circleButton.tag = 1
        cell.squareButton.tag = 1
      }
      if(indexPath.section == 3)
      {
        cell.titleLabel.text = bloodSugar[indexPath.row] as? String
        cell.circleButton.tag = 2
        cell.squareButton.tag = 2
      }

      return cell
    }
    
        // MARK: - IndicatorInfoProvider

    func indicatorInfoForPagerTabStrip(pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }

}
