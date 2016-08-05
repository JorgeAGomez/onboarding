
//
//  QuestionnarieVC.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-07-25.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import Foundation
import XLPagerTabStrip
import SimplePDF

public class QuestionnarieVC: TwitterPagerTabStripViewController {

var personalInformation = [:]
var medicalInformation = [:]
var workInjuryInformation = [:]
var motorVehicleInjuryInformation = [:]
var healthCoverageInformation = [:]
var conditionsInformation = [:]
let myColor : UIColor = UIColor( red: 0, green: 122/255, blue:255/255, alpha: 1.0)

var isReload = false
  
  public override func viewDidLoad() {
    settings.style.selectedDotColor = myColor
    settings.style.dotColor = UIColor.blackColor()
    settings.style.titleColor = UIColor.blackColor()
    super.viewDidLoad()
    self.navigationItem.hidesBackButton = true
  }
  
  public override func viewControllersForPagerTabStrip(pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let child_1 = GeneralTableViewController(style: .Plain, itemInfo: "General")
        let child_2 = ImmuneSystemInfectonTVCTableViewController(style: .Plain, itemInfo: "Immune System / infection")
        let child_3 = GastrointestinalTableViewController(style: .Plain, itemInfo: "Gastrointestinal")
        let child_4 = CardiovascularTableViewController(style: .Plain, itemInfo: "Cardiovascular")
        let child_5 = MultipleSectionsTableViewController(style: .Grouped, itemInfo: "Other Systems")
        let child_6 = NeuromusculoskeletalTableViewController(style: .Grouped, itemInfo: "Neuromusculoskeletal")
        
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
  
  @IBOutlet weak var nextButton: UIBarButtonItem!
  
  
  @IBAction func nextButton(sender: AnyObject) {
      let A4paperSize = CGSize(width: 595, height: 842)
      let pdf = SimplePDF(pageSize: A4paperSize, pageMargin: 20.0)
      var generalString = ""
      for data in dic1 {
        generalString.appendContentsOf(data.0)
        pdf.addText(generalString)
        pdf.addLineSeparator()
      }
    
      pdf.addLineSeparator(height: 30) // or pdf.addLineSeparator() default height is 1.0
      pdf.addLineSpace(20)
    
    if let documentDirectories = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first {
    
    let fileName = "example.pdf"
    let documentsFileName = documentDirectories + "/" + fileName
    
    let pdfData = pdf.generatePDFdata()
    do{
        try pdfData.writeToFile(documentsFileName, options: .DataWritingAtomic)
        print("\nThe generated pdf can be found at:")
        print("\n\t\(documentsFileName)\n")
    }catch{
        print(error)
    }
}
  }
}
