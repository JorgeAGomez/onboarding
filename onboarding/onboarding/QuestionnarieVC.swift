
//
//  QuestionnarieVC.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-07-25.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import Foundation
import SimplePDF
import MessageUI
import FirebaseDatabase
import FirebaseStorage


class QuestionnarieVC: UIViewController, MFMailComposeViewControllerDelegate {

var personalInformation = NSMutableDictionary()
var medicalInformation = NSMutableDictionary()
var workInjuryInformation = NSMutableDictionary()
var motorVehicleInjuryInformation = NSMutableDictionary()
var healthCoverageInformation = NSMutableDictionary()
var conditionsInformation = NSMutableDictionary()
let myColor : UIColor = UIColor( red: 0, green: 122/255, blue:255/255, alpha: 1.0)
var temp = false
var isReload = false
var downloadURL = NSURL()
  
  override func viewDidLoad(){
      super.viewDidLoad()
    
    self.navigationItem.hidesBackButton = true
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: self, action: #selector(doneTapped))
    
    // Create the alert controller
    let alertController = UIAlertController(title: "Instructions", message: "Swipe the screen left or right to nagivate through the questionnarie", preferredStyle: .Alert)

    // Create the actions
    let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)

    // Add the actions
    alertController.addAction(okAction)
    
    
  }
  
  
  /*func sendEmail(){
            func configuredMailComposeViewController() -> MFMailComposeViewController {
                let mailComposerVC = MFMailComposeViewController()
                mailComposerVC.mailComposeDelegate = QuestionnarieVC() // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
                
                mailComposerVC.setToRecipients(["physio4D@icloud.com"])
                mailComposerVC.setSubject("Sending you an in-app e-mail...")
                mailComposerVC.setMessageBody("Click link to access patient PDF file:", isHTML: false)
                
                return mailComposerVC
            }
            
            func showSendMailErrorAlert() {
                let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
                sendMailErrorAlert.show()
            }
            
              func mailComposeController(controller:MFMailComposeViewController, didFinishWithResult result:MFMailComposeResult, error:NSError) {
                switch result.rawValue {
                case MFMailComposeResultCancelled.rawValue:
                    print("Mail cancelled")
                case MFMailComposeResultSaved.rawValue:
                    print("Mail saved")
                case MFMailComposeResultSent.rawValue:
                    print("Mail sent")
                case MFMailComposeResultFailed.rawValue:
                    print("Mail sent failure: \(error.localizedDescription)")
                default:
                    break
                }
                self.dismissViewControllerAnimated(false, completion: nil)
            }
    
            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
              self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            }
            else {
              showSendMailErrorAlert()
            }

  }*/
  
  
  func doneTapped(){
    
      //PERSONAL INFORMATION
      let personalKeys = NSMutableArray()
      for i in personalInformation{
        if(i.value.isEqual(NSNull())){
          personalKeys.addObject(i.key)
        }
      }
      for object in personalKeys
      {
        personalInformation.removeObjectForKey(object)
        personalInformation.setValue("", forKey: object as! String)
      }
      
      //MEDICAL INFORMATION
      let medicalKeys = NSMutableArray()
      for i in medicalInformation
      {
        if(i.value.isEqual(NSNull()))
        {
          medicalKeys.addObject(i.key)
        }
      }
      
      for object in medicalKeys
      {
        medicalInformation.removeObjectForKey(object)
        medicalInformation.setValue("", forKey: object as! String)
      }
    
      //WORK RELATED INJURY
      let workKeys = NSMutableArray()
      for i in workInjuryInformation
      {
        if(i.value.isEqual(NSNull()))
        {
          workKeys.addObject(i.key)
        }
      }
      
      for object in workKeys
      {
        workInjuryInformation.removeObjectForKey(object)
        workInjuryInformation.setValue("", forKey: object as! String)
      }
    
      //CAR ACCIDENT
      let carKeys = NSMutableArray()
      for i in motorVehicleInjuryInformation
      {
        if(i.value.isEqual(NSNull()))
        {
          carKeys.addObject(i.key)
        }
      }
      
      for object in medicalKeys
      {
        motorVehicleInjuryInformation.removeObjectForKey(object)
        motorVehicleInjuryInformation.setValue("", forKey: object as! String)
      }
    
      //PERSONAL INFORMATION
      let firstName = personalInformation["First name"] as! String
      let lastName = personalInformation["Last name"] as! String
      let address = personalInformation["Address"] as! String
      let city = personalInformation["City"] as! String
      let postalCode = personalInformation["Postal Code"] as! String
      let province = personalInformation["Province"] as! String
      let homePhone = personalInformation["Home Phone #"] as! String
      let cellPhone = personalInformation["Cell Phone #"] as! String
      let workPhone = personalInformation["Work Phone #"] as! String
      let DOB = personalInformation["Date of Birth"]
      let PHN = personalInformation["PHN No."] as! String
    
      //MEDICAL INFORMATION
      let emergencyContact = medicalInformation["Emergency Contact"] as! String
      let contactPhone = medicalInformation["Contact Phone"] as! String
      let doctorName = medicalInformation["Medical Doctor's Name"] as! String
      let doctorPhone = medicalInformation["Doctor Phone"] as! String
      let doctorAddress = medicalInformation["Address"] as! String
    
      //WORK RELATED INJURY
      var dateInjury = NSDate()
      var WCB = String()
      var employer = String()
      var phoneNumber = String()
      var employerAddress = String()
      var canContact = String()
    
      if((workInjuryInformation["Work Related Injury"]!.isEqualToString("Yes")))
      {
        dateInjury = workInjuryInformation["Date of Injury"] as! NSDate
        WCB = workInjuryInformation["WCB Claim No."] as! String
        employer  = workInjuryInformation["Employer"] as! String
        phoneNumber = workInjuryInformation["Employer Phone"] as! String
        employerAddress = workInjuryInformation["Employer Address"] as! String
        canContact = workInjuryInformation["Contact employer"] as! String
      }
    
      //MOTOR VEHICLE ACCIDENT
      var insuranceCompany = String()
      var accidentDate = NSDate()
      var claimNumber = String()
      var adjuster = String()
      var adjusterPhone = String()
      var fax = String()
      var namePolicy = String()
      var legalRep = String()
    
      if(motorVehicleInjuryInformation["Motor Vehicle Injury"]!.isEqualToString("Yes")){
        insuranceCompany = motorVehicleInjuryInformation["Insurence"] as! String
        accidentDate = motorVehicleInjuryInformation["Date of accident"] as! NSDate
        claimNumber = motorVehicleInjuryInformation["Claim/Policy #"] as! String
        adjuster = motorVehicleInjuryInformation["Adjuster"] as! String
        adjusterPhone = motorVehicleInjuryInformation["Phone No."] as! String
        fax = motorVehicleInjuryInformation["Fax #"] as! String
        namePolicy = motorVehicleInjuryInformation["Name on Policy"] as! String
        legalRep = motorVehicleInjuryInformation["Legal Representative"] as! String
      }
    
      //HEALTH COVERAGE
      var insuranceCompanyCoverage = String()
      if(healthCoverageInformation["Extended Health Coverage"]!.isEqualToString("Yes")){
        insuranceCompanyCoverage = healthCoverageInformation["Extended Health Coverage"] as! String
      }
      
      let dateFormatter = NSDateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd"
    
      let firstPage = CGSize(width: 650, height: 842)
      let pdf = SimplePDF(pageSize: firstPage, pageMargin: 33.0)
      var borderSize : CGFloat = 1.0
      
      let logoImage = UIImage(named:"CaleoLogo133x53")!
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

      pdf.addText("Patient's / Guarantor's Initials: \(firstName.characters.first) \(lastName.characters.first)")
      let date = NSDate()
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
      pdf.addText("Patient's / Guarantor's Initials: \(firstName.characters.first) \(lastName.characters.first)")
      pdf.addText("Date: \(stringDate)")
      //pdf.addText("Consent reviewed with patient: Therapist's Signature / Initials or Office stamp: ______")
    
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
      pdf.addText("Home Phone #: \(homePhone)        Cell Phone #: \(cellPhone)        Work Phone #: \(workPhone)")
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
        
        pdf.setFont(UIFont(name: "HelveticaNeue", size: 15)!)
        pdf.addText("Work Related Injury")
        pdf.addLineSeparator()
        pdf.addLineSpace(15)
        pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
        let stringDateInjury = dateFormatter.stringFromDate(dateInjury)
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
        
        pdf.setFont(UIFont(name: "HelveticaNeue", size: 15)!)
        pdf.addText("Motor Vehicle Accident")
        pdf.addLineSeparator()
        pdf.addLineSpace(15)
        pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
        let stringAccidentDate = dateFormatter.stringFromDate(accidentDate)
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
        
        pdf.setFont(UIFont(name: "HelveticaNeue", size: 15)!)
        pdf.addText("Extended Health Coverage")
        pdf.addLineSeparator()
        pdf.addLineSpace(15)
        pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
        pdf.addText("Insurance Company: \(insuranceCompanyCoverage)")
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
      for i in conditionsInformation {
        var temp = [String]()
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
      if(finalCondition.count == 0){
        borderSize = 0.0
        pdf.addText("No conditions recorded")
      }
    
      pdf.addTable(finalCondition.count, columnCount: 2, rowHeight: 20, columnWidth: 200, tableLineWidth: borderSize, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: finalCondition)
      pdf.addLineSpace(20)
    
      //QUESTIONNARIE
      
      pdf.beginNewPage()
    
      //GENERAL
      pdf.addImage(logoImage)
      pdf.addLineSpace(18)
      pdf.setContentAlignment(.Center)
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 22)!)
      pdf.addText("Health Report Questionnarie")
      pdf.addLineSpace(15)
      pdf.setContentAlignment(.Left)
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
      pdf.addText("For the following conditions please check: \(circleScalar) for previously had and \(squareScalar) for presently have")
      pdf.addLineSpace(15)
    
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 15)!)
      pdf.addText("General")
      pdf.setFont(UIFont(name: "HelveticaNeue", size: 12)!)
      pdf.addLineSeparator()
      pdf.addLineSpace(15)
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
      
      //If no conditions are checked, then removeAll() to not show the table.
      if(finalGeneral.count < 2)
      {
        finalGeneral.removeAll()
        pdf.addText("N/A")
      }
      else
      {
        pdf.addTable(finalGeneral.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: borderSize, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: finalGeneral)
      }
    
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
      
      if(immuneFinal.count < 2)
      {
        immuneFinal.removeAll()
        pdf.addText("N/A")
      }
      else
      {
        pdf.addTable(immuneFinal.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: borderSize, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: immuneFinal)
      }
    
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
      
      if(gastroFinal.count < 2){
        gastroFinal.removeAll()
        pdf.addText("N/A")
      }
      else
      {
        pdf.addTable(gastroFinal.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: borderSize, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: gastroFinal)
      }
    
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
      
      if(cardioFinal.count < 2){
        cardioFinal.removeAll()
        pdf.addText("N/A")
      }
      else
      {
        pdf.addTable(cardioFinal.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: borderSize, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: cardioFinal)
      }
      
    
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
      
      if(nervousFinal.count < 2)
      {
        nervousFinal.removeAll()
        pdf.addText("N/A")
      }
      else
      {
        pdf.addTable(nervousFinal.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: borderSize, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: nervousFinal)
      }
    
      //RESPIRATORY
      borderSize = 1.0
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
      
      if(respiratoryFinal.count < 2){
        respiratoryFinal.removeAll()
        pdf.addText("N/A")
      }
      else{
        pdf.addTable(respiratoryFinal.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: borderSize, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: respiratoryFinal)
      }
     
    
      //BLOOD SUGAR
      borderSize = 1.0
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
      if(bloodSugarFinal.count < 2){
        bloodSugarFinal.removeAll()
        pdf.addText("N/A")
      }
      else{
        pdf.addTable(bloodSugarFinal.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: borderSize, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: bloodSugarFinal)
      }
      
      
      //EYE EAR NOSE AND THROAT
      borderSize = 1.0
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
      
      if(eyeEarNoseThroatFinal.count < 2){
        eyeEarNoseThroatFinal.removeAll()
        pdf.addText("N/A")
      }
      else{
        pdf.addTable(eyeEarNoseThroatFinal.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: borderSize, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: eyeEarNoseThroatFinal)
      }
      
    
    
      //URINARY TRACT
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
      
      if(urinaryTractFinal.count == 1){
        urinaryTractFinal.removeAll()
        pdf.addText("N/A")
      }
      else{
        pdf.addTable(urinaryTractFinal.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: borderSize, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: urinaryTractFinal)
      }
      
      
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
      if(headNeckFinal.count == 1){
        headNeckFinal.removeAll()
        pdf.addText("N/A")
      }
      else{
        pdf.addTable(headNeckFinal.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: borderSize, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: headNeckFinal)
      }
      
      
    
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
      
      if(shoulderFinal.count == 1){
        shoulderFinal.removeAll()
        pdf.addText("N/A")
      }
      else{
        pdf.addTable(shoulderFinal.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: borderSize, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: shoulderFinal)
      }
      
    
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
      
      if(midFinal.count == 1){
        midFinal.removeAll()
        pdf.addText("N/A")
      }
      else{
        pdf.addTable(midFinal.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: borderSize, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: midFinal)
      }
      
     

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
      
      if(lowFinal.count == 1){
        lowFinal.removeAll()
        pdf.addText("N/A")
      }
      else{
        pdf.addTable(lowFinal.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: borderSize, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: lowFinal)
      }
      
      
    
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
      if(armsFinal.count == 1){
        armsFinal.removeAll()
        pdf.addText("N/A")
      }
      else{
        pdf.addTable(armsFinal.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: borderSize, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: armsFinal)
      }
      
    
    
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
      
      if(hipsFinal.count == 1){
        hipsFinal.removeAll()
        pdf.addText("N/A")
      }
      else{
        pdf.addTable(hipsFinal.count, columnCount: 3, rowHeight: 20, columnWidth: 150, tableLineWidth: borderSize, font: UIFont(name: "HelveticaNeue", size: 11)!, dataArray: hipsFinal)
      }
      
      pdf.addLineSpace(15)
    
    
    let pdfData = pdf.generatePDFdata()
    do{
        let storage = FIRStorage.storage()
        let storageReference = storage.referenceForURL("gs://project-4839952831808961167.appspot.com")
      
        let pdfFile: NSData = pdfData
        let pdfReference = storageReference.child("PatientsOnboardingForms/\(firstName)\(lastName).pdf/")
        let uploadTask = pdfReference.putData(pdfFile, metadata: nil) { pdfFile, error in
          if(error != nil){
            print("An error has occcurred")
            print(error)
          }
          else{
            self.downloadURL = pdfFile!.downloadURL()!
          }
        }
      }
    
    
      /********* FIREBASE ************/
    
      FirebaseHelperSwift.personalInformation(firstName, lastName: lastName, address: address, city: city, postalCode: postalCode, province: province, homePhone: homePhone, cellPhone: cellPhone, workPhone: workPhone, DOB: DOB as! NSDate, PHN: PHN)

      FirebaseHelperSwift.medicalInformation(emergencyContact, emergencyPhoneNumber: contactPhone, medicalDoctorName: doctorName, doctorPhoneNumber: doctorPhone, address: doctorAddress)
    
      FirebaseHelperSwift.workRelatedInjury(dateInjury, WCBClaimNumber: WCB, employer: employer, employerPhoneNumber: phoneNumber, address: employerAddress, mayContactEmployer: canContact)
    
      FirebaseHelperSwift.motorVehicleAccident(insuranceCompany, dateOfAccident: accidentDate, claimPolicyNumber: claimNumber, adjuster: adjuster, phoneNumber: adjusterPhone, faxNumber: fax, nameOnPolicy: namePolicy, legalRepresentative: legalRep)
    
      FirebaseHelperSwift.healthCoverage(insuranceCompanyCoverage)
    
      FirebaseHelperSwift.conditions(finalCondition)
    
      FirebaseHelperSwift.questGeneral(finalGeneral)
    
      FirebaseHelperSwift.questImmune(immuneFinal)
    
      FirebaseHelperSwift.questGastro(gastroFinal)
    
      FirebaseHelperSwift.questCardio(cardioFinal)
    
      FirebaseHelperSwift.questNervous(nervousFinal)
    
      FirebaseHelperSwift.questRespiratory(respiratoryFinal)
    
      FirebaseHelperSwift.questBloodSugar(bloodSugarFinal)
    
      FirebaseHelperSwift.questEyeEarNoseThroat(eyeEarNoseThroatFinal)
    
      FirebaseHelperSwift.questUrinary(urinaryTractFinal)
    
      FirebaseHelperSwift.questHeadNeck(headNeckFinal)
    
      FirebaseHelperSwift.questShoulder(shoulderFinal)
    
      FirebaseHelperSwift.questMidBack(midFinal)
    
      FirebaseHelperSwift.questLowBack(lowFinal)
    
      FirebaseHelperSwift.questArmsHands(armsFinal)
    
      FirebaseHelperSwift.questHipsLegsFeets(hipsFinal)
    
      /*****************************/
    }
  }
