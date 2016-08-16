//
//  SecondMultipleTableViewController.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-08-12.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit
import XLPagerTabStrip

var eyeEarNoseThroat = []
var eyeEarNoseThroatData = [String:[String:String]]()
var eyeEarNoseThroatDic = [String:String]()

var urinaryTract = []
var urinaryTractData = [String:[String:String]]()
var urinaryTractDic = [String:String]()

class SecondMultipleTableViewController: UITableViewController, IndicatorInfoProvider {

    let cellIdentifier = "SecondMultiple"
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

    override func viewDidLoad() {
        super.viewDidLoad()
        eyeEarNoseThroat = ["Vision Problems","Hoarseness","Nose Bleeding","Ear Pain","Dental Problems","Hearing Loss","Store Throat","Ringing in Ear(s)"]
        urinaryTract = ["Blood in Urine","Bladder Infection","Inability to Control Urination"," Kidney Stones","Painful Urination"]
      
        tableView.registerNib(UINib(nibName: "PostCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: cellIdentifier)
        if blackTheme {
            tableView.backgroundColor = UIColor(red: 15/255.0, green: 16/255.0, blue: 16/255.0, alpha: 1.0)
          
        }
      
        for i in eyeEarNoseThroat{
          eyeEarNoseThroatDic = ["previously":"No","presently":"No","Selected":"No"]
          eyeEarNoseThroatData.updateValue(eyeEarNoseThroatDic, forKey: i as! String)
        }
      
        for i in urinaryTract{
          urinaryTractDic = ["previously":"No","presently":"No","Selected":"No"]
          urinaryTractData.updateValue(urinaryTractDic, forKey: i as! String)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
  
    override func viewWillDisappear(animated: Bool) {
      
      for cells in tableView.visibleCells{
        let cell = cells as! PostCellTableViewCell
        //EYE EAR NOSE AND THROAT
        if(cell.circleButton.tag == 0 && cell.squareButton.tag == 0)
        {
          if(cell.circleButton.backgroundColor == myColor){
            eyeEarNoseThroatData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "previously")
          }
          else{
            eyeEarNoseThroatData[cell.titleLabel.text!]!.updateValue("No", forKey: "previously")
          }
          if(cell.squareButton.backgroundColor == myColor){
            eyeEarNoseThroatData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "presently")
          }
          else{
            eyeEarNoseThroatData[cell.titleLabel.text!]!.updateValue("No", forKey: "presently")
          }
        }
        
        //URINARY TRACT
        if(cell.circleButton.tag == 1 && cell.squareButton.tag == 1)
        {
          if(cell.circleButton.backgroundColor == myColor){
            urinaryTractData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "previously")
          }
          else{
            urinaryTractData[cell.titleLabel.text!]!.updateValue("No", forKey: "previously")
          }
          if(cell.squareButton.backgroundColor == myColor){
            urinaryTractData[cell.titleLabel.text!]!.updateValue("Yes", forKey: "presently")
          }
          else{
            urinaryTractData[cell.titleLabel.text!]!.updateValue("No", forKey: "presently")
          }
        }
      }
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(section == 0)
        {
         return 0
        }
        if(section == 1){
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
        return "Please check: \(circleScalar) for previously had and \(squareScalar) for presently have"
      }
      if(section == 1)
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
      cell.selectionStyle = UITableViewCellSelectionStyle.None
      cell.contentView.userInteractionEnabled = false
      cell.circleButton.layer.borderWidth = 1
      cell.circleButton.layer.borderColor = myColor.CGColor
      cell.squareButton.layer.borderColor = myColor.CGColor

      if(indexPath.section == 1)
      {
        cell.titleLabel.text = eyeEarNoseThroat[indexPath.row] as? String
        cell.circleButton.tag = 0
        cell.squareButton.tag = 0
      }
      if(indexPath.section == 2)
      {
        cell.titleLabel.text = urinaryTract[indexPath.row] as? String
        cell.circleButton.tag = 1
        cell.squareButton.tag = 1
      }
      
      return cell
    }
    

    // MARK: - IndicatorInfoProvider

    func indicatorInfoForPagerTabStrip(pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }

}
