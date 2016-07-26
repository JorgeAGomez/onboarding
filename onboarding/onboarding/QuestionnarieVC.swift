//
//  QuestionnarieVC.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-07-25.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import Foundation
import XLPagerTabStrip

public class QuestionnarieVC: TwitterPagerTabStripViewController {

var personalInformation = [:]
var medicalInformation = [:]
var workInjuryInformation = [:]
var motorVehicleInjuryInformation = [:]
var healthCoverageInformation = [:]
var conditionsInformation = [:]
let swiftColor = UIColor(red: 1, green: 165/255, blue: 0, alpha: 1)

var isReload = false
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.hidesBackButton = true;
    //self.view.backgroundColor = UIColor.blackColor()
  }
  
  public override func viewControllersForPagerTabStrip(pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let child_1 = GeneralTableViewController(style: .Plain, itemInfo: "General")
        let child_2 = ImmuneSystemInfectonTVCTableViewController(style: .Plain, itemInfo: "Immune System / infection")
        let child_3 = GastrointestinalTableViewController(style: .Plain, itemInfo: "Gastrointestinal")
        let child_4 = CardiovascularTableViewController(style: .Plain, itemInfo: "Cardiovascular")
        let child_5 = MultipleSectionsTableViewController(style: .Grouped, itemInfo: "Multiple")
        let child_6 = NeuromusculoskeletalTableViewController(style: .Grouped, itemInfo: "Neuromusculoskeletal")
        //let child_7
        //let child_8
        //let child_9
        
        guard isReload else {
            return [child_1,child_2, child_3,child_4,child_5,child_6]
        }
        
        var childViewControllers = [child_1,child_2,child_3,child_4,child_5,child_6]
        
        for (index, _) in childViewControllers.enumerate(){
            let nElements = childViewControllers.count - index
            let n = (Int(arc4random()) % nElements) + index
            if n != index{
                swap(&childViewControllers[index], &childViewControllers[n])
            }
        }
        reloadPagerTabStripView()
        let nItems = 1 + (rand() % 6)
        return Array(childViewControllers.prefix(Int(nItems)))
    
    }
  
}
