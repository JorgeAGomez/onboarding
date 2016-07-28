//
//  NeuromusculoskeletalTableViewController.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-07-26.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class NeuromusculoskeletalTableViewController: UITableViewController, IndicatorInfoProvider {

    var headNeck = []
    var shoulder = []
    var midback = []
    var lowback = []
    var armshands = []
    var hipsLegsFeet = []
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

  
    override func viewDidLoad() {
        super.viewDidLoad()
        headNeck = ["Headaches","Neck Pain / stiffness","Pinched nerve","Jaw Pain / TMJ","Arthritis in neck"]
        shoulder = ["Shoulder pain","Can't raise arm"," arthritis","Bursitis","Clicking / popping"]
        midback = ["Mid back Pain","Pain between shoulders","Muscle spasms","Sharp stabbing pain"]
        lowback = ["Low Back Pain","Low Back stiffness","Tailbone pain","Muscle Spasms","Pinched nerve"]
        armshands = ["Pain in elbow / arm","Pain in forearm","Pain in hands / fingers","Arthritis / swollen hands","Cold hands","Carpal Tunnel","Tingling in hands","Loss of grip strength"]
        hipsLegsFeet = ["Pain in buttock","Pain in hip / knee joint","Cold feet","Tingling in feet","Arthritis","Sprain / strain","Pain down leg(s)","Tingling in leg(s)","Swollen ankle / feet","Pain in ankle / feet","Loss of leg strength","Muscles cramps"]
        tableView.registerNib(UINib(nibName: "PostCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: cellIdentifier)
        if blackTheme {
            tableView.backgroundColor = UIColor(red: 15/255.0, green: 16/255.0, blue: 16/255.0, alpha: 1.0)
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 6
    }
  
        override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
      if(section == 0)
      {
        return "Head & Neck"
      }
      if(section == 1)
      {
       return "Shoulder"
      }
      if(section == 2)
      {
        return "Mid-Back"
      }
      if(section == 3)
      {
        return "Low-Back"
      }
      if(section == 4)
      {
        return "Arms & Hands"
      }
      else
      {
        return "Hips, Legs & Feet"
      }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
      if(section == 0)
      {
        return headNeck.count
      }
      if(section == 1)
      {
        return shoulder.count
      }
      if(section == 2)
      {
        return midback.count
      }
      if(section == 3)
      {
        return lowback.count
      }
      if(section == 4)
      {
        return armshands.count
      }
      else
      {
        return hipsLegsFeet.count
      }
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PostCellTableViewCell
      
      cell.selectionStyle = UITableViewCellSelectionStyle.None
      cell.contentView.userInteractionEnabled = false
      cell.circleButton.layer.borderWidth = 1
      let myColor : UIColor = UIColor( red: 0, green: 122/255, blue:255/255, alpha: 1.0)
      cell.circleButton.layer.borderColor = myColor.CGColor
      cell.squareButton.layer.borderColor = myColor.CGColor
      
      if(indexPath.section == 0)
      {
        cell.titleLabel.text = headNeck[indexPath.row] as? String
      }
      if(indexPath.section == 1)
      {
        cell.titleLabel.text = shoulder[indexPath.row] as? String
      }
      if(indexPath.section == 2)
      {
        cell.titleLabel.text = midback[indexPath.row] as? String
      }
      if(indexPath.section == 3)
      {
        cell.titleLabel.text = lowback[indexPath.row] as? String
      }
      if(indexPath.section == 4)
      {
        cell.titleLabel.text = armshands[indexPath.row] as? String
      }
      else
      {
        cell.titleLabel.text = hipsLegsFeet[indexPath.row] as? String
      }
      return cell
    }
 
    // MARK: - IndicatorInfoProvider

    func indicatorInfoForPagerTabStrip(pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}
