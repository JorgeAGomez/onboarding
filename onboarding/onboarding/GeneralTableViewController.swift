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
var general:NSArray = []

let blackCircleCode = 0x026AB
let blackSquareCode = 0x02B1B
let circleScalar = UnicodeScalar(blackCircleCode)
let squareScalar = UnicodeScalar(blackSquareCode)
var pageControl = UIPageControl()

class GeneralTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

  @IBOutlet weak var tableView: UITableView!
  var personalInformation = NSMutableDictionary()
  var medicalInformation = NSMutableDictionary()
  var workInjuryInformation = NSMutableDictionary()
  var motorVehicleInjuryInformation = NSMutableDictionary()
  var healthCoverageInformation = NSMutableDictionary()
  var conditionsInformation = NSMutableDictionary()
  //var noNo = true
  
    let cellIdentifier = "Cell"
    let myColor : UIColor = UIColor( red: 0, green: 122/255, blue:255/255, alpha: 1.0)
    var origin = CGPoint()
  
    override func viewDidLoad()
    {
      super.viewDidLoad()
      
      self.navigationItem.hidesBackButton = true
      self.navigationItem.title = "General"
      self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextTapped))
      let navBarSize = self.navigationController!.navigationBar.bounds.size
      
     
        origin = CGPoint(x: navBarSize.width / 2, y: navBarSize.height / 2)
        pageControl = UIPageControl(frame: CGRect(x: origin.x, y: origin.y+15, width: 0, height: 0))
        //Or whatever number of viewcontrollers you have
        pageControl.numberOfPages = 9
        pageControl.pageIndicatorTintColor = UIColor.black
        pageControl.currentPageIndicatorTintColor = myColor
        self.navigationController!.navigationBar.addSubview(pageControl)
      general = ["Diabetes","Hypoglycemia","Stress / Depression","Epilepsy / Seizures", "Skin conditions / Rashes","Alcoholism","High Cholesterol","Parkinson's disease","Heart disease","Cancer","Osteoarthritis","Ulcers","Anemia / Fatigue", "Multiple Sclerosis","Thyroid","Osteoporosis"]

      for i in general
      {
        generalDic = ["previously":"No","presently":"No"]
        dic1.updateValue(generalDic, forKey: i as! String)
      }
    }
  
  
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      var controller = ImmuneSystemViewController()
      controller = segue.destination as! ImmuneSystemViewController
      controller.personalInformation = personalInformation
      controller.medicalInformation = medicalInformation
      controller.workInjuryInformation = workInjuryInformation
      controller.motorVehicleInjuryInformation = motorVehicleInjuryInformation
      controller.healthCoverageInformation = healthCoverageInformation
      controller.conditionsInformation = conditionsInformation
    }
  
    func nextTapped(){
      self.performSegue(withIdentifier: "goToImmune", sender: self)
    }
  
    override func viewWillAppear(_ animated: Bool) {
      pageControl.currentPage = 0
    }
    

    override func viewWillDisappear(_ animated: Bool) {
      let table = tableView
     for cell in (table?.visibleCells)! {
        let cells = cell as! GeneralTableViewCell
        if(cells.circleButton.backgroundColor == myColor)
        {
          dic1[cells.nameLabel.text!]!.updateValue("Yes", forKey: "previously")
        }
        else
        {
          dic1[cells.nameLabel.text!]!.updateValue("No", forKey: "previously")
        }
        if(cells.squareButton.backgroundColor == myColor)
        {
          dic1[cells.nameLabel.text!]!.updateValue("Yes", forKey: "presently")
        }
        else
        {
          dic1[cells.nameLabel.text!]!.updateValue("No", forKey: "presently")
        }
     }
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return general.count
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
      let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! GeneralTableViewCell
      cell.selectionStyle = UITableViewCellSelectionStyle.none
      cell.nameLabel.text = general[indexPath.row] as? String
      cell.circleButton.layer.borderColor = myColor.cgColor
      cell.squareButton.layer.borderColor = myColor.cgColor
    
      
      return cell
    }
  
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "Please check: \(circleScalar) for previously had and \(squareScalar) for presently have"
    }

}
