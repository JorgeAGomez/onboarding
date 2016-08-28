//
//  GeneralTableViewController.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-07-25.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit

var generalDic = [String:String]()
var dic1 = [String:[String:String]]()
var general = []

let blackCircleCode = 0x026AB
let blackSquareCode = 0x02B1B
let circleScalar = UnicodeScalar(blackCircleCode)
let squareScalar = UnicodeScalar(blackSquareCode)
var pageControl = UIPageControl()

class GeneralTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

  @IBOutlet weak var tableView: UITableView!
  
  
    let cellIdentifier = "Cell"
    let myColor : UIColor = UIColor( red: 0, green: 122/255, blue:255/255, alpha: 1.0)
    var origin = CGPoint()
  
    override func viewDidLoad()
    {
      super.viewDidLoad()
      
      self.navigationItem.title = "General"
      self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: #selector(nextTapped))
      var navBarSize = self.navigationController!.navigationBar.bounds.size
      origin = CGPointMake(navBarSize.width / 2, navBarSize.height / 2)
      pageControl = UIPageControl(frame: CGRectMake(origin.x, origin.y+15, 0, 0))
      //Or whatever number of viewcontrollers you have
      pageControl.numberOfPages = 8
      pageControl.pageIndicatorTintColor = UIColor.redColor()
      pageControl.currentPageIndicatorTintColor = UIColor.blueColor()
      self.navigationController!.navigationBar.addSubview(pageControl)

      general = ["Diabetes","Hypoglycemia","Stress / Depression","Epilepsy / Seizures", "Skin conditions / Rashes","Alcoholism","High Cholesterol","Parkinson's disease","Heart disease","Cancer","Osteoarthritis","Ulcers","Anemia / Fatigue", "Multiple Sclerosis","Thyroid","Osteoporosis"]

      for i in general
      {
        generalDic = ["previously":"No","presently":"No"]
        dic1.updateValue(generalDic, forKey: i as! String)
      }
    }
  
    func nextTapped(){
      self.performSegueWithIdentifier("goToImmune", sender: self)
    }
  
    override func viewWillAppear(animated: Bool) {
      pageControl.currentPage = 0
    }
    

    override func viewWillDisappear(animated: Bool) {
      let table = tableView
//     for cell in table.visibleCells {
//        let cells = cell as! GeneralTableViewCell
//        if(cells.circleButton.backgroundColor == myColor)
//        {
//          dic1[cells.titleLabel.text!]!.updateValue("Yes", forKey: "previously")
//        }
//        else
//        {
//          dic1[cells.titleLabel.text!]!.updateValue("No", forKey: "previously")
//        }
//        if(cells.squareButton.backgroundColor == myColor)
//        {
//          dic1[cells.titleLabel.text!]!.updateValue("Yes", forKey: "presently")
//        }
//        else
//        {
//          dic1[cells.titleLabel.text!]!.updateValue("No", forKey: "presently")
//        }
//     }
    }
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return general.count
    }
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
      let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! GeneralTableViewCell
      cell.selectionStyle = UITableViewCellSelectionStyle.None
      cell.contentView.userInteractionEnabled = false
      cell.nameLabel.text = general[indexPath.row] as? String
      cell.circleButton.layer.borderColor = myColor.CGColor
      cell.squareButton.layer.borderColor = myColor.CGColor
    
      
      return cell
    }
  
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "Please check: \(circleScalar) for previously had and \(squareScalar) for presently have"
    }

}
