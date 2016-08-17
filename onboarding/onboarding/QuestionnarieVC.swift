
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
import MessageUI
import FirebaseDatabase
import FirebaseStorage


//Adding this extension to String class all these are true: (Use to get initials from firstName and lastName)
//                      "abcde"[0] == "a"
//                      "abcde"[0...2] == "abc"
//                      "abcde"[2..<4] == "cd"


extension String {

  subscript (i: Int) -> Character {
    return self[self.startIndex.advancedBy(i)]
  }

  subscript (i: Int) -> String {
    return String(self[i] as Character)
  }

  subscript (r: Range<Int>) -> String {
    let start = startIndex.advancedBy(r.startIndex)
    let end = start.advancedBy(r.endIndex - r.startIndex)
    return self[Range(start ..< end)]
  }
}

public class QuestionnarieVC: TwitterPagerTabStripViewController, MFMailComposeViewControllerDelegate {

var personalInformation = [:]
var medicalInformation = [:]
var workInjuryInformation = [:]
var motorVehicleInjuryInformation = [:]
var healthCoverageInformation = [:]
var conditionsInformation = [:]
let myColor : UIColor = UIColor( red: 0, green: 122/255, blue:255/255, alpha: 1.0)

var temp = false
var isReload = false
  
  public override func viewDidLoad()
  {
    settings.style.selectedDotColor = myColor
    settings.style.dotColor = UIColor.blackColor()
    settings.style.titleColor = UIColor.blackColor()
    
    super.viewDidLoad()
    
    self.navigationItem.hidesBackButton = true
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: self, action: #selector(doneTapped))
    
    // Create the alert controller
    let alertController = UIAlertController(title: "Instructions", message: "Swipe left and right to nagivate through the questionnarie", preferredStyle: .Alert)

    // Create the actions
    let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)

    // Add the actions
    alertController.addAction(okAction)

    // Present the controller
    self.presentViewController(alertController, animated: true, completion: nil)
  }
  
  public override func viewControllersForPagerTabStrip(pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let child_1 = GeneralTableViewController(style: .Grouped, itemInfo: "General")
        let child_2 = ImmuneSystemInfectonTVCTableViewController(style: .Grouped, itemInfo: "Immune System / infection")
        let child_3 = GastrointestinalTableViewController(style: .Grouped, itemInfo: "Gastrointestinal")
        let child_4 = CardiovascularTableViewController(style: .Grouped, itemInfo: "Cardiovascular")
        let child_5 = MultipleSectionsTableViewController(style: .Grouped, itemInfo: "Other Systems")
        let child_6 = SecondMultipleTableViewController(style: .Grouped, itemInfo: "Other Systems")
        let child_7 = NeuromusculoskeletalTableViewController(style: .Grouped, itemInfo: "Neuromusculoskeletal")
        let child_8 = SecondNeuroTableViewController(style: .Grouped, itemInfo: "Neuromusculoskeletal II")
        let child_9 = HipsLegsFeetTableViewController(style: .Grouped, itemInfo: "Hips, Legs and Feet")
    
        guard isReload else {
            return [child_1,child_2, child_3,child_4,child_5,child_6,child_7, child_8,child_9]
        }
        
        var childViewControllers = [child_1,child_2,child_3,child_4,child_5,child_6,child_7,child_8,child_9]
        
        for (index, _) in childViewControllers.enumerate(){
            let nElements = childViewControllers.count - index
            let n = (Int(arc4random()) % nElements) + index
            if n != index{
                swap(&childViewControllers[index], &childViewControllers[n])
            }
        }
        reloadPagerTabStripView()
        let nItems = 1 + (rand() % 9)
        return Array(childViewControllers.prefix(Int(nItems)))
    
    }
  
    func doneTapped(){
  
     let firstPage = CGSize(width: 650, height: 842)
      let pdf = SimplePDF(pageSize: firstPage, pageMargin: 33.0)
    
      let firstName = personalInformation["First name"]!
      let lastName = personalInformation["Last name"]!
      let address = personalInformation["Address"]!
      let city = personalInformation["City"]!
      let postalCode = personalInformation["Postal Code"]!
      let province = personalInformation["Province"]!
      let homePhone = personalInformation["Home Phone #"]!
      let cellPhone = personalInformation["Cell Phone #"]!
      let workPhone = personalInformation["Work Phone #"]!
      let DOB = personalInformation["Date of Birth"]!
      let PHN = personalInformation["PHN No."]!
    
      let emergencyContact = medicalInformation["Emergency Contact"]!
      let contactPhone = medicalInformation["Contact Phone"]!
      let doctorName = medicalInformation["Medical Doctor's Name"]!
      let doctorPhone = medicalInformation["Doctor Phone"]!
      let doctorAddress = medicalInformation["Address"]!
  
      
      let logoImage = UIImage(named:"CaleoLogo201x80")!
      pdf.addImage(logoImage)
      pdf.addLineSpace(18)
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 22)!)
      pdf.setContentAlignment(.Center)
      pdf.addText("INFORMED CONSENT")
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
      pdf.addLineSeparator()
      pdf.addLineSpace(20)
      pdf.setContentAlignment(.Left)
      pdf.addText("Dear patient: Your information is confidential. We need this information so that we can better care for you. Your consent will help us determine if treatment in our office will benefit you. If we do not sincerely believe your condition will respond satisfactorily, we will not accept your case. In order for us to understand your condition properly, please be as neat and complete as possible while completing all form.")
      pdf.addLineSpace(30)
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 15)!)
      pdf.addText("Consent to Assessment and Treatment")
      pdf.addLineSeparator()
      pdf.addLineSpace(15)
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
      pdf.addText("Physiotherapy, physical therapy has been subject to government reports and multidisciplinary studies and has been demonstrated to be highly effective treatment for joint pain, back and neck pain, headaches and other similar symptoms.")
      pdf.addLineSpace(15)
      pdf.addText("I, \(firstName) \(lastName) hereby request and consent to the performance physiotherapy, massage including various modalities, acupuncture, gait analysis, which may be deemed appropriate for therapeutic and or diagnostic purposes. These modalities may include, but are not limited to: electrical muscle/nerve stimulation; spinal manipulative therapy; laser/electrical acupuncture, therapeutic ultrasound; mobilization; soft tissue manipulation; diagnostic x-rays; and various forms of physio/physical therapy performed by the physiotherapist, therapist aide, kinesiologist and/or anyone authorized by the therapist.")
      pdf.addLineSpace(15)
      pdf.addText("I understand that, as is the case with most health care interventions, there is a certain inherent risk of complication associated with physiotherapy, acupuncture, physiotherapeutic and/or rehabilitative procedures, which may include but is not limited to skin irritation; bruising; muscle strains/sprains; disc injuries; infection and stroke. The risk of complication/injury associated with the aforementioned procedures is small and subsequently reduced when performed by a certified and/or licensed professional.")
      pdf.addLineSpace(15)
      pdf.addText("I understand my therapist or doctor will not be able to anticipate and explain all risks and complications, but I elect to rely on his/her clinical expertise and judgment to determine reasonable course(s) of clinical action, based upon known facts, which are considered to be in my best interest. I understand the results are not guaranteed and that I have the opportunity to discuss the purposes and risks associated with any and all recommended evaluations and treatment procedures.")
      pdf.addLineSpace(15)
      pdf.addText("By initialing below, I hereby acknowledge that I have read and understood the preceding statements. I have also had an opportunity to ask questions and address any concerns in regards to its content. I intend this consent form to serve as written consent throughout the entire course of treatment of my present condition and for any future condition(s) for which I may seek treatment at Caleo Health. If at any time I decide that I am unwilling to engage or continue with these procedures, I reserve the right to inform my therapist or doctor of such, and withdraw my consent at anytime in any or all forms of evaluation and/or treatment.")
      pdf.addLineSpace(15)
      pdf.addText("Patient's / Guarantor's Initials: \(firstName) \(lastName)")
      let date = NSDate()
      let dateFormatter = NSDateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd"
      let stringDate = dateFormatter.stringFromDate(date)
      pdf.addText("Date: \(stringDate)")
    
      //////////
    
      pdf.beginNewPage()
      pdf.addImage(logoImage)
      pdf.addLineSpace(18)
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 15)!)
      pdf.addText("Consent to Release and/or Collect Medical information")
      pdf.addLineSeparator()
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
      pdf.addLineSpace(15)
      pdf.addText("I hereby authorize Caleo Health or any agent acting on behalf of the aforementioned to disclose or collect, verbal or written, any or all relevant medical information pertinent to my case to: medical/technical consultants; legal representatives; insurance carriers and third party payers involved in the case.")
      pdf.addLineSpace(15)
      pdf.addText("By signing below, I hereby acknowledge that I have read and understand the above statements, and consent to the release of any or all relevant medical information pertinent to my case to: medical/technical consultants; legal representatives; insurance carriers and third party payers involved in the case. I reserve the right to inform my therapist or doctor of such, and withdraw my consent at anytime in whole or in part to the information within.")
      pdf.addLineSpace(15)
      pdf.addText("Patient's / Guarantor's Initials: \(firstName) \(lastName)")
      pdf.addText("Date: \(stringDate)")
      pdf.addText("Consent reviewed with patient: Therapist's Signature / Initials or Office stamp: ______")
    
      ////////////
    
      pdf.beginNewPage()
      pdf.addImage(logoImage)
      pdf.addLineSpace(18)
      pdf.setContentAlignment(.Center)
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 22)!)
      pdf.addText("New Patient Information Form")
      pdf.addLineSpace(15)
      pdf.setContentAlignment(.Left)
    
      // PERSONAL INFORMATION
    
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 15)!)
      pdf.addText("Personal Information")
      pdf.addLineSeparator()
      pdf.addLineSpace(15)
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 11)!)
      pdf.addText("PLEASE ASSIST US TO PROVIDE YOU WITH OPTIMUM CARE BY CAREFULLY ANSWERING EACH SECTION OF THIS FORM. ALL INFORMATION ON THE FORM WILL BE KEPT CONFIDENTIAL.")
      pdf.addLineSpace(15)
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
      pdf.addText("First name: \(firstName)        Last name: \(lastName)")
      pdf.addLineSpace(4)
      pdf.addText("Address: \(address)")
      pdf.addLineSpace(4)
      pdf.addText("City / Province: \(city), \(province)        Postal Code: \(postalCode)")
      pdf.addLineSpace(4)
      pdf.addText("Home Phone #: \(homePhone)        Cell Phone #: \(cellPhone)        Work Phone: \(workPhone)")
      pdf.addLineSpace(4)
      let stringDOB = dateFormatter.stringFromDate(DOB as! NSDate)
      pdf.addText("Date of birth: \(stringDOB)        PHN #: \(PHN)")
      pdf.addLineSpace(15)
    
      // MEDICAL INFORMATION
    
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 15)!)
      pdf.addText("Medical Information")
      pdf.addLineSeparator()
      pdf.addLineSpace(15)
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
      pdf.addText("Emergency Contact Name: \(emergencyContact)        Emergency Contact Phone #: \(contactPhone)")
      pdf.addLineSpace(4)
      pdf.addText("Medical Doctor's Name: \(doctorName)        Phone #: \(doctorPhone)")
      pdf.addLineSpace(4)
      pdf.addText("Address: \(doctorAddress)")
      pdf.addLineSpace(15)
    
    
      if((workInjuryInformation["Work Related Injury"]!).isEqualToString("Yes")){
        
        let dateInjury = workInjuryInformation["Date of Injury"]!
        let WCB = workInjuryInformation["WCB Claim No."]!
        let employer  = workInjuryInformation["Employer"]!
        let phoneNumber = workInjuryInformation["Employer Phone"]!
        let employerAddress = workInjuryInformation["Employer Address"]!
        let canContact = workInjuryInformation["Contact employer"]!

        pdf.setFont(UIFont(name: "HelveticaNeue", size: 15)!)
        pdf.addText("Work Related Injury")
        pdf.addLineSeparator()
        pdf.addLineSpace(15)
        pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
        let stringDateInjury = dateFormatter.stringFromDate(dateInjury as! NSDate)
        pdf.addText("Date of Injury: \(stringDateInjury)        WCB Claim #: \(WCB)")
        pdf.addLineSpace(4)
        pdf.addText("Employer: \(employer)         Phone #: \(phoneNumber)")
        pdf.addLineSpace(4)
        pdf.addText("Address: \(employerAddress)        May we contact your employer? \(canContact)")
        pdf.addLineSpace(15)
        
      }
      else{
        pdf.setFont(UIFont(name: "HelveticaNeue", size: 15)!)
        pdf.addText("Work Related Injury")
        pdf.addLineSeparator()
        pdf.addLineSpace(15)
        pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
        pdf.addText("N/A")
        pdf.addLineSpace(15)
      }
    
      if(motorVehicleInjuryInformation["Motor Vehicle Injury"]!.isEqualToString("Yes")){
        let insuranceCompany = motorVehicleInjuryInformation["Insurence"]!
        let accidentDate = motorVehicleInjuryInformation["Date of accident"]!
        let claimNumber = motorVehicleInjuryInformation["Claim/Policy #"]!
        let adjuster = motorVehicleInjuryInformation["Adjuster"]!
        let adjusterPhone = motorVehicleInjuryInformation["Phone No."]!
        let fax = motorVehicleInjuryInformation["Fax #"]!
        let namePolicy = motorVehicleInjuryInformation["Name on Policy"]!
        let legalRep = motorVehicleInjuryInformation["Legal Representative"]!
        
        pdf.setFont(UIFont(name: "HelveticaNeue", size: 15)!)
        pdf.addText("Motor Vehicle Accident")
        pdf.addLineSeparator()
        pdf.addLineSpace(15)
        pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
        let stringAccidentDate = dateFormatter.stringFromDate(accidentDate as! NSDate)
        pdf.addText("Insurance Company: \(insuranceCompany)        Date of Injury: \(stringAccidentDate)")
        pdf.addLineSpace(4)
        pdf.addText("Claim / Policy #: \(claimNumber)        Adjuster: \(adjuster)")
        pdf.addLineSpace(4)
        pdf.addText("Phone #: \(adjusterPhone)        Fax #: \(fax)")
        pdf.addLineSpace(4)
        pdf.addText("Name on Policy: \(namePolicy)        Legal Representative(if applicable): \(legalRep)")
        pdf.addLineSpace(15)
      }
      else{
        pdf.setFont(UIFont(name: "HelveticaNeue", size: 15)!)
        pdf.addText("Motor Vehicle Accident")
        pdf.addLineSeparator()
        pdf.addLineSpace(15)
        pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
        pdf.addText("N/A")
        pdf.addLineSpace(15)
      }
    
      if(healthCoverageInformation["Extended Health Coverage"]!.isEqualToString("Yes")){
        let insuranceCompany = healthCoverageInformation["Extended Health Coverage"]!
        pdf.setFont(UIFont(name: "HelveticaNeue", size: 15)!)
        pdf.addText("Extended Health Coverage")
        pdf.addLineSeparator()
        pdf.addLineSpace(15)
        pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
        pdf.addText("Insurance Company: \(insuranceCompany)")
        pdf.addLineSpace(15)
      
      }
      else{
        pdf.setFont(UIFont(name: "HelveticaNeue", size: 15)!)
        pdf.addText("Extended Health Coverage")
        pdf.addLineSeparator()
        pdf.addLineSpace(15)
        pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
        pdf.addText("N/A")
        pdf.addLineSpace(15)
      }
    
      pdf.beginNewPage()
      pdf.addImage(logoImage)
      pdf.addLineSpace(18)
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 22)!)
      pdf.setContentAlignment(.Center)
      pdf.addText("Conditions")
      pdf.setContentAlignment(.Left)
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
      pdf.addLineSeparator()
      pdf.addLineSpace(15)
      pdf.addText("Check off any of the following conditions that you may be experiencing:")
      pdf.addLineSeparator()
      pdf.addLineSpace(15)
    
    
      let blackCircleCode = 0x026AB
      let box_with_checkMark = 0x02611
      let blackSquareCode = 0x02B1B
      let circleScalar = UnicodeScalar(blackCircleCode)
      let checkMarkScalar = UnicodeScalar(box_with_checkMark)
      let squareScalar = UnicodeScalar(blackSquareCode)
    
    
      var finalCondition = [[String]]()
      print(conditionsInformation)
      for i in conditionsInformation {
        var temp = [String]()
        print(i.key)
        print(i.value)
        if(i.key.isEqualToString("Medications") && !i.value.isEqual("No")){
          temp.append(i.key as! String)
          temp.append(i.value as! String)
          finalCondition.append(temp)
          continue
        }
        if(i.key.isEqualToString("Allergies") && !i.value.isEqual("No")){
          temp.append(i.key as! String)
          temp.append(i.value as! String)
          finalCondition.append(temp)
          continue
        }
        if(!i.value .isEqual((NSNull()))){
          if(i.value.isEqual("No")){
            continue
          }
          else{
            temp.append(i.key as! String)
            temp.append("\(checkMarkScalar)")
            finalCondition.append(temp)
          }
        }
      }
    
      pdf.addTable(finalCondition.count, columnCount: 2, rowHeight: 20, columnWidth: 160, tableLineWidth: 1, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: finalCondition)
      pdf.addLineSpace(20)
    
      //QUESTIONNARIE
      pdf.beginNewPage()
      pdf.addImage(logoImage)
      pdf.addLineSpace(18)
      pdf.setContentAlignment(.Center)
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 22)!)
      pdf.addText("Health Report Questionnarie")
      pdf.addLineSpace(15)
      pdf.setContentAlignment(.Left)
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
      pdf.addText("For the following conditions please check: CIRCLE for previously had and SQUARE for presently have")
      pdf.addLineSpace(15)
    
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 15)!)
      pdf.addText("General")
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
      pdf.addLineSeparator()
      pdf.addLineSpace(15)
    
    
      //GENERAL
      var finalGeneral = [[String]]()
      let firstRow = ["Conditions","Previously had","Presently have"]
      finalGeneral.append(firstRow)
      for i in dic1{
        var temp = [String]()
        temp.append(i.0)
        let previouslyData = i.1["previously"]
        let presentlyData = i.1["presently"]
        if(previouslyData == "Yes"){
          temp.append("\(circleScalar)")
        }
        else{
          temp.append(" ")
        }
        if(presentlyData == "Yes"){
          temp.append("\(squareScalar)")
        }
        else{
          temp.append(" ")
        }
        if(!(temp[1] == " " && temp[2] == " ")){
          finalGeneral.append(temp)
        }
      }
    
      pdf.addTable(finalGeneral.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: 1, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: finalGeneral)
    
      //IMMUNE SYSTEM / INFECTION
      pdf.addLineSpace(15)
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 15)!)
      pdf.addText("Immune System / infection")
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
      pdf.addLineSeparator()
      pdf.addLineSpace(15)
    
      var immuneFinal = [["Condition","Previously had","Presently have"]]
      for i in immuneData{
        var temp = [String]()
        temp.append(i.0)
        let previouslyData = i.1["previously"]
        let presentlyData = i.1["presently"]
        if(previouslyData == "Yes"){
          temp.append("\(circleScalar)")
        }
        else{
          temp.append(" ")
        }
        if(presentlyData == "Yes"){
          temp.append("\(squareScalar)")
        }
        else{
          temp.append(" ")
        }
        if(!(temp[1] == " " && temp[2] == " ")){
          immuneFinal.append(temp)
        }
      }
      pdf.addTable(immuneFinal.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: 1, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: immuneFinal)
    
    
      //GASTROINSTESTINAL

      pdf.addLineSpace(15)
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 15)!)
      pdf.addText("Gastrointestinal")
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
      pdf.addLineSeparator()
      pdf.addLineSpace(15)
    
      var gastroFinal = [["Condition","Previously had","Presently have"]]
      for i in gastroData
      {
        var temp = [String]()
        temp.append(i.0)
        let previouslyData = i.1["previously"]
        let presentlyData = i.1["presently"]
        if(previouslyData == "Yes"){
          temp.append("\(circleScalar)")
        }
        else{
          temp.append(" ")
        }
        if(presentlyData == "Yes"){
          temp.append("\(squareScalar)")
        }
        else{
          temp.append(" ")
        }
        if(!(temp[1] == " " && temp[2] == " ")){
          gastroFinal.append(temp)
        }
      }
      pdf.addTable(gastroFinal.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: 1, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: gastroFinal)
    
    
      //CARDIOVASCULAR
    
      pdf.addLineSpace(15)
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 15)!)
      pdf.addText("Cardiovascular")
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
      pdf.addLineSeparator()
      pdf.addLineSpace(15)
    
      var cardioFinal = [["Condition","Previously had","Presently have"]]
    
      for i in cardioData
      {
        var temp = [String]()
        temp.append(i.0)
        let previouslyData = i.1["previously"]
        let presentlyData = i.1["presently"]
        if(previouslyData == "Yes"){
          temp.append("\(circleScalar)")
        }
        else{
          temp.append(" ")
        }
        if(presentlyData == "Yes"){
          temp.append("\(squareScalar)")
        }
        else{
          temp.append(" ")
        }
        if(!(temp[1] == " " && temp[2] == " ")){
          cardioFinal.append(temp)
        }
      }
      pdf.addTable(cardioFinal.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: 1, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: cardioFinal)
    
      //OTHER SYSTEMS
      //NERVOUS SYSTEM
      pdf.addLineSpace(15)
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 15)!)
      pdf.addText("Nervous System")
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
      pdf.addLineSeparator()
      pdf.addLineSpace(15)
      var nervousFinal = [["Condition","Previously had","Presently have"]]
      for i in nervousData
      {
        var temp = [String]()
        temp.append(i.0)
        let previouslyData = i.1["previously"]
        let presentlyData = i.1["presently"]
        if(previouslyData == "Yes"){
          temp.append("\(circleScalar)")
        }
        else{
          temp.append(" ")
        }
        if(presentlyData == "Yes"){
          temp.append("\(squareScalar)")
        }
        else{
          temp.append(" ")
        }
        if(!(temp[1] == " " && temp[2] == " ")){
          nervousFinal.append(temp)
        }
      }
      pdf.addTable(nervousFinal.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: 1, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: nervousFinal)
    
      //RESPIRATORY
      pdf.addLineSpace(15)
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 15)!)
      pdf.addText("Respiratory")
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
      pdf.addLineSeparator()
      pdf.addLineSpace(15)
      var respiratoryFinal = [["Condition","Previously had","Presently have"]]
      for i in respiratoryData
      {
        var temp = [String]()
        temp.append(i.0)
        let previouslyData = i.1["previously"]
        let presentlyData = i.1["presently"]
        if(previouslyData == "Yes"){
          temp.append("\(circleScalar)")
        }
        else{
          temp.append(" ")
        }
        if(presentlyData == "Yes"){
          temp.append("\(squareScalar)")
        }
        else{
          temp.append(" ")
        }
        if(!(temp[1] == " " && temp[2] == " ")){
          respiratoryFinal.append(temp)
        }
      }
      pdf.addTable(respiratoryFinal.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: 1, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: respiratoryFinal)
    
    
      //BLOOD SUGAR
      pdf.addLineSpace(15)
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 15)!)
      pdf.addText("Blood sugar")
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
      pdf.addLineSeparator()
      pdf.addLineSpace(15)
      var bloodSugarFinal = [["Condition","Previously had","Presently have"]]
      for i in bloodSugarData
      {
        var temp = [String]()
        temp.append(i.0)
        let previouslyData = i.1["previously"]
        let presentlyData = i.1["presently"]
        if(previouslyData == "Yes"){
          temp.append("\(circleScalar)")
        }
        else{
          temp.append(" ")
        }
        if(presentlyData == "Yes"){
          temp.append("\(squareScalar)")
        }
        else{
          temp.append(" ")
        }
        if(!(temp[1] == " " && temp[2] == " ")){
          bloodSugarFinal.append(temp)
        }
      }
      pdf.addTable(bloodSugarFinal.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: 1, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: bloodSugarFinal)
    
      pdf.beginNewPage()
    
      //EYE EAR NOSE AND THROAT
      pdf.addLineSpace(15)
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 15)!)
      pdf.addText("Eye, Ear, Nose and Throat")
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
      pdf.addLineSeparator()
      pdf.addLineSpace(15)
      var eyeEarNoseThroatFinal = [["Condition","Previously had","Presently have"]]
      for i in eyeEarNoseThroatData
      {
        var temp = [String]()
        temp.append(i.0)
        let previouslyData = i.1["previously"]
        let presentlyData = i.1["presently"]
        if(previouslyData == "Yes"){
          temp.append("\(circleScalar)")
        }
        else{
          temp.append(" ")
        }
        if(presentlyData == "Yes"){
          temp.append("\(squareScalar)")
        }
        else{
          temp.append(" ")
        }
        if(!(temp[1] == " " && temp[2] == " ")){
          eyeEarNoseThroatFinal.append(temp)
        }
      }
      pdf.addTable(eyeEarNoseThroatFinal.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: 1, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: eyeEarNoseThroatFinal)
    
      pdf.addLineSpace(15)
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 15)!)
      pdf.addText("Urinary Tract")
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
      pdf.addLineSeparator()
      pdf.addLineSpace(15)
      var urinaryTractFinal = [["Condition","Previously had","Presently have"]]
      for i in urinaryTractData
      {
        var temp = [String]()
        temp.append(i.0)
        let previouslyData = i.1["previously"]
        let presentlyData = i.1["presently"]
        if(previouslyData == "Yes"){
          temp.append("\(circleScalar)")
        }
        else{
          temp.append(" ")
        }
        if(presentlyData == "Yes"){
          temp.append("\(squareScalar)")
        }
        else{
          temp.append(" ")
        }
        if(!(temp[1] == " " && temp[2] == " ")){
          urinaryTractFinal.append(temp)
        }
      }
      pdf.addTable(urinaryTractFinal.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: 1, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: urinaryTractFinal)
    
      //HEAD & NECK
      pdf.addLineSpace(19)
      pdf.setContentAlignment(.Center)
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 18)!)
      pdf.addText("Neuromusculoskeletal")
      pdf.setContentAlignment(.Left)
      pdf.addLineSpace(15)
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 15)!)
      pdf.addText("Head & Neck")
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
      pdf.addLineSeparator()
      pdf.addLineSpace(15)
      var headNeckFinal = [["Condition","Previously had","Presently have"]]
      for i in headNeckData
      {
        var temp = [String]()
        temp.append(i.0)
        let previouslyData = i.1["previously"]
        let presentlyData = i.1["presently"]
        if(previouslyData == "Yes"){
          temp.append("\(circleScalar)")
        }
        else{
          temp.append(" ")
        }
        if(presentlyData == "Yes"){
          temp.append("\(squareScalar)")
        }
        else{
          temp.append(" ")
        }
        if(!(temp[1] == " " && temp[2] == " ")){
          headNeckFinal.append(temp)
        }
      }
      pdf.addTable(headNeckFinal.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: 1, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: headNeckFinal)
    
      //SHOULDER
      pdf.addLineSpace(15)
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 15)!)
      pdf.addText("Shoulder")
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
      pdf.addLineSeparator()
      pdf.addLineSpace(15)
      var shoulderFinal = [["Condition","Previously had","Presently have"]]
      for i in shoulderData
      {
        var temp = [String]()
        temp.append(i.0)
        let previouslyData = i.1["previously"]
        let presentlyData = i.1["presently"]
        if(previouslyData == "Yes"){
          temp.append("\(circleScalar)")
        }
        else{
          temp.append(" ")
        }
        if(presentlyData == "Yes"){
          temp.append("\(squareScalar)")
        }
        else{
          temp.append(" ")
        }
        if(!(temp[1] == " " && temp[2] == " ")){
          shoulderFinal.append(temp)
        }
      }
      pdf.addTable(shoulderFinal.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: 1, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: shoulderFinal)
    
      //MID BACK
      pdf.addLineSpace(15)
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 15)!)
      pdf.addText("Mid-Back")
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
      pdf.addLineSeparator()
      pdf.addLineSpace(15)
      var midFinal = [["Condition","Previously had","Presently have"]]
      for i in midData
      {
        var temp = [String]()
        temp.append(i.0)
        let previouslyData = i.1["previously"]
        let presentlyData = i.1["presently"]
        if(previouslyData == "Yes"){
          temp.append("\(circleScalar)")
        }
        else{
          temp.append(" ")
        }
        if(presentlyData == "Yes"){
          temp.append("\(squareScalar)")
        }
        else{
          temp.append(" ")
        }
        if(!(temp[1] == " " && temp[2] == " ")){
          midFinal.append(temp)
        }
      }
      pdf.addTable(midFinal.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: 1, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: midFinal)

      //LOW BACK
      pdf.addLineSpace(15)
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 15)!)
      pdf.addText("Low-Back")
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
      pdf.addLineSeparator()
      pdf.addLineSpace(15)
      var lowFinal = [["Condition","Previously had","Presently have"]]
      for i in lowData
      {
        var temp = [String]()
        temp.append(i.0)
        let previouslyData = i.1["previously"]
        let presentlyData = i.1["presently"]
        if(previouslyData == "Yes"){
          temp.append("\(circleScalar)")
        }
        else{
          temp.append(" ")
        }
        if(presentlyData == "Yes"){
          temp.append("\(squareScalar)")
        }
        else{
          temp.append(" ")
        }
        if(!(temp[1] == " " && temp[2] == " ")){
          lowFinal.append(temp)
        }
      }
      pdf.addTable(lowFinal.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: 1, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: lowFinal)
    
      //ARMS AND HANDS
      pdf.addLineSpace(15)
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 15)!)
      pdf.addText("Arms & Hands")
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
      pdf.addLineSeparator()
      pdf.addLineSpace(15)
      var armsFinal = [["Condition","Previously had","Presently have"]]
      for i in armsData
      {
        var temp = [String]()
        temp.append(i.0)
        let previouslyData = i.1["previously"]
        let presentlyData = i.1["presently"]
        if(previouslyData == "Yes"){
          temp.append("\(circleScalar)")
        }
        else{
          temp.append(" ")
        }
        if(presentlyData == "Yes"){
          temp.append("\(squareScalar)")
        }
        else{
          temp.append(" ")
        }
        if(!(temp[1] == " " && temp[2] == " ")){
          armsFinal.append(temp)
        }
      }
      pdf.addTable(armsFinal.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: 1, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: armsFinal)
    
    
      //HIPS LEGS FEET
      pdf.addLineSpace(15)
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 15)!)
      pdf.addText("Hips, Legs and Feet")
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
      pdf.addLineSeparator()
      pdf.addLineSpace(15)
      var hipsFinal = [["Condition","Previously had","Presently have"]]
      for i in hipsData
      {
        var temp = [String]()
        temp.append(i.0)
        let previouslyData = i.1["previously"]
        let presentlyData = i.1["presently"]
        if(previouslyData == "Yes"){
          temp.append("\(circleScalar)")
        }
        else{
          temp.append(" ")
        }
        if(presentlyData == "Yes"){
          temp.append("\(squareScalar)")
        }
        else{
          temp.append(" ")
        }
        if(!(temp[1] == " " && temp[2] == " ")){
          hipsFinal.append(temp)
        }
      }
      pdf.addTable(hipsFinal.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: 1, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: hipsFinal)
      pdf.addLineSpace(15)
    
    /*

      pdf.addLineSpace(15)*/
    
    /*if let documentDirectories = NSSearchPathForDirectoriesInDomains( .DocumentDirectory, .UserDomainMask, true).first {
    
    let fileName = "onboardingForm.pdf"
    let documentsFileName = documentDirectories + "/" + fileName
    
    let pdfData = pdf.generatePDFdata()
    

    
    do{
        try pdfData.writeToFile(documentsFileName, options: .DataWritingAtomic)
        print("\nThe generated pdf can be found at:")
        print("\n\t\(documentsFileName)\n")
    }catch{
        print(error)
    }
    
    let mailComposer = MFMailComposeViewController()
    mailComposer.mailComposeDelegate = self

    //Set to recipients
    mailComposer.setToRecipients(["jorge_gomez12@hotmail.com"])

    //Set the subject
    mailComposer.setSubject("email with document pdf")

    //set mail body
    mailComposer.setMessageBody("Check the PDF file.", isHTML: true)
    
    mailComposer.addAttachmentData(pdfData, mimeType: "pdf", fileName: "onboarding.pdf")
  
    self.presentViewController(mailComposer, animated: true, completion: nil)

    }
    
    //this will compose and present mail to user
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }*/
    
    
    let pdfData = pdf.generatePDFdata()
    do{
      
        let storage = FIRStorage.storage()
        let storageReference = storage.referenceForURL("gs://project-4839952831808961167.appspot.com")
      
        let pdfFile: NSData = pdfData
        let pdfReference = storageReference.child("\(PHN)/onboarding.pdf")
        let uploadTask = pdfReference.putData(pdfFile, metadata: nil) { pdfFile, error in
          if(error != nil){
            print("An error has occcurred")
            print(error)
          }
          else{
            let downloadURL = pdfFile!.downloadURL
            print(downloadURL)
          }
        }
      }
    }
  }
