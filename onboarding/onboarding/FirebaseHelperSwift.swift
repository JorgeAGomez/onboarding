//
//  FirebaseHelperSwift.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-08-19.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

var homePhoneId = String()
var cellPhoneId = String()
var workPhoneId = String()
var nameId = String()


class FirebaseHelperSwift{

//PERSONAL INFORMATION

static func personalInformation(firstName: String, lastName: String, address: String, city: String, postalCode: String, province: String, homePhone: String, cellPhone: String, workPhone: String, DOB: NSDate, PHN: String){
  let dbReference = FIRDatabase.database().reference()
  
  let dateFormatter = NSDateFormatter()
  dateFormatter.dateFormat = "yyyy-MM-dd"
  let stringDOB = dateFormatter.stringFromDate(DOB)
  
  homePhoneId = homePhone
  cellPhoneId = cellPhone
  workPhoneId = workPhone
  nameId = firstName
  
  dbReference.child("patientInformation").child("\(homePhone)\(cellPhone)\(workPhone)\(firstName)").child("personalInformation").setValue(["firstName":firstName,
                                                                                                                                           "lastName":lastName,
                                                                                                                                           "address":address,
                                                                                                                                           "city":city,
                                                                                                                                           "postalCode":postalCode,
                                                                                                                                           "province":province,
                                                                                                                                           "homePhone":homePhone,
                                                                                                                                           "cellPhone":cellPhone,
                                                                                                                                           "workPhone":workPhone,
                                                                                                                                           "dateOfBirth":stringDOB,
                                                                                                                                           "PHN":PHN])
}

//MEDICAL INFORMATION

static func medicalInformation(emergencyContact: String, emergencyPhoneNumber: String, medicalDoctorName: String, doctorPhoneNumber: String, address: String){
  let dbReference = FIRDatabase.database().reference()
  dbReference.child("patientInformation").child("\(homePhoneId)\(cellPhoneId)\(workPhoneId)\(nameId)").child("medicalInformation").setValue(["emergencyContact":emergencyContact,
                                                                                                                                             "emergencyPhoneNumber":emergencyPhoneNumber,
                                                                                                                                             "medicalDoctorName":medicalDoctorName,
                                                                                                                                             "doctorPhoneNumber":doctorPhoneNumber,
                                                                                                                                             "address":address])
}


//WORK RELATED INJURY

static func workRelatedInjury(dateOfInjury: NSDate, WCBClaimNumber: String, employer: String, employerPhoneNumber: String, address: String, mayContactEmployer:String){
  let dbReference = FIRDatabase.database().reference()
  let dateFormatter = NSDateFormatter()
  dateFormatter.dateFormat = "yyyy-MM-dd"
  var stringDate = String()
  if(WCBClaimNumber == "" && employer == ""){
    stringDate = ""
  }
  else{
     stringDate = dateFormatter.stringFromDate(dateOfInjury)
  }
  dbReference.child("patientInformation").child("\(homePhoneId)\(cellPhoneId)\(workPhoneId)\(nameId)").child("workRelatedInjury").setValue(["dateOfInjury":stringDate,
                                                                                                                                            "WCBClainNumber":WCBClaimNumber,
                                                                                                                                            "employer":employer,
                                                                                                                                            "employerPhone":employerPhoneNumber,
                                                                                                                                            "address":address,
                                                                                                                                            "mayContactEmployer":mayContactEmployer])
}

//MOTOR VEHICLE ACCIDENT

static func motorVehicleAccident(insuranceCompany: String, dateOfAccident: NSDate, claimPolicyNumber: String, adjuster: String, phoneNumber: String, faxNumber: String, nameOnPolicy: String, legalRepresentative: String){
  let dbReference = FIRDatabase.database().reference()
  let dateFormatter = NSDateFormatter()
  dateFormatter.dateFormat = "yyyy-MM-dd"
  var stringDate = String()
  if(insuranceCompany == "" && claimPolicyNumber == ""){
    stringDate = ""
  }
  else{
    stringDate = dateFormatter.stringFromDate(dateOfAccident)
  }
  dbReference.child("patientInformation").child("\(homePhoneId)\(cellPhoneId)\(workPhoneId)\(nameId)").child("motorVehicleAccident").setValue(["insuranceCompany":insuranceCompany,
                                                                                                                                               "dateOfAccident":stringDate,
                                                                                                                                               "claimPolicyNumber":claimPolicyNumber,
                                                                                                                                               "adjuster":adjuster,
                                                                                                                                               "phoneNumber":phoneNumber,
                                                                                                                                               "faxNumber":faxNumber,
                                                                                                                                               "nameOnPolicy":nameOnPolicy,
                                                                                                                                               "legalRepresentative":legalRepresentative])
}

//EXTENDED HEALTH COVERAGE

static func healthCoverage(insuranceCompany: String){
  let dbReference = FIRDatabase.database().reference()
  dbReference.child("patientInformation").child("\(homePhoneId)\(cellPhoneId)\(workPhoneId)\(nameId)").child("healthCoverage").setValue(["insuranceCompany":insuranceCompany])
}

//CONDITIONS

static func conditions(conditions: [[String]]){
  let dbReference = FIRDatabase.database().reference()
  dbReference.child("patientInformation").child("\(homePhoneId)\(cellPhoneId)\(workPhoneId)\(nameId)").child("questionnarie").child("conditions").setValue(conditions)
}

//ENTIRE QUESTIONNARIE

static func questGeneral(general: [[String]]){
  let dbReference = FIRDatabase.database().reference()
  dbReference.child("patientInformation").child("\(homePhoneId)\(cellPhoneId)\(workPhoneId)\(nameId)").child("questionnarie").child("general").setValue(general)
}

static func questImmune(immune: [[String]]){
  let dbReference = FIRDatabase.database().reference()
  dbReference.child("patientInformation").child("\(homePhoneId)\(cellPhoneId)\(workPhoneId)\(nameId)").child("questionnarie").child("immuneSystem").setValue(immune)
}

static func questGastro(gastro: [[String]]){
  let dbReference = FIRDatabase.database().reference()
  dbReference.child("patientInformation").child("\(homePhoneId)\(cellPhoneId)\(workPhoneId)\(nameId)").child("questionnarie").child("gastrointestinal").setValue(gastro)
}

static func questCardio(cardio: [[String]]){
  let dbReference = FIRDatabase.database().reference()
  dbReference.child("patientInformation").child("\(homePhoneId)\(cellPhoneId)\(workPhoneId)\(nameId)").child("questionnarie").child("cardiovascular").setValue(cardio)
}

static func questNervous(nervous: [[String]]){
  let dbReference = FIRDatabase.database().reference()
  dbReference.child("patientInformation").child("\(homePhoneId)\(cellPhoneId)\(workPhoneId)\(nameId)").child("questionnarie").child("nervousSystem").setValue(nervous)
}

static func questRespiratory(respiratory: [[String]]){
  let dbReference = FIRDatabase.database().reference()
  dbReference.child("patientInformation").child("\(homePhoneId)\(cellPhoneId)\(workPhoneId)\(nameId)").child("questionnarie").child("respiratory").setValue(respiratory)
}

static func questBloodSugar(bloodSugar: [[String]]){
  let dbReference = FIRDatabase.database().reference()
  dbReference.child("patientInformation").child("\(homePhoneId)\(cellPhoneId)\(workPhoneId)\(nameId)").child("questionnarie").child("bloodSugar").setValue(bloodSugar)
}

static func questEyeEarNoseThroat(eyeEarNoseThroat: [[String]]){
  let dbReference = FIRDatabase.database().reference()
  dbReference.child("patientInformation").child("\(homePhoneId)\(cellPhoneId)\(workPhoneId)\(nameId)").child("questionnarie").child("eyeEarNoseThroat").setValue(eyeEarNoseThroat)
}

static func questUrinary(urinaryTract: [[String]]){
  let dbReference = FIRDatabase.database().reference()
  dbReference.child("patientInformation").child("\(homePhoneId)\(cellPhoneId)\(workPhoneId)\(nameId)").child("questionnarie").child("urinaryTract").setValue(urinaryTract)
}

static func questHeadNeck(headNeck: [[String]]){
  let dbReference = FIRDatabase.database().reference()
  dbReference.child("patientInformation").child("\(homePhoneId)\(cellPhoneId)\(workPhoneId)\(nameId)").child("questionnarie").child("headNeck").setValue(headNeck)
}

static func questShoulder(shoulder: [[String]]){
  let dbReference = FIRDatabase.database().reference()
  dbReference.child("patientInformation").child("\(homePhoneId)\(cellPhoneId)\(workPhoneId)\(nameId)").child("questionnarie").child("shoulder").setValue(shoulder)
}

static func questMidBack(midBack: [[String]]){
  let dbReference = FIRDatabase.database().reference()
  dbReference.child("patientInformation").child("\(homePhoneId)\(cellPhoneId)\(workPhoneId)\(nameId)").child("questionnarie").child("midBack").setValue(midBack)
}

static func questLowBack(lowBack: [[String]]){
  let dbReference = FIRDatabase.database().reference()
  dbReference.child("patientInformation").child("\(homePhoneId)\(cellPhoneId)\(workPhoneId)\(nameId)").child("questionnarie").child("lowBack").setValue(lowBack)
}

static func questArmsHands(armsHands: [[String]]){
  let dbReference = FIRDatabase.database().reference()
  dbReference.child("patientInformation").child("\(homePhoneId)\(cellPhoneId)\(workPhoneId)\(nameId)").child("questionnarie").child("armsHands").setValue(armsHands)
}

static func questHipsLegsFeets(hipsLegsFeets: [[String]]){
  let dbReference = FIRDatabase.database().reference()
  dbReference.child("patientInformation").child("\(homePhoneId)\(cellPhoneId)\(workPhoneId)\(nameId)").child("questionnarie").child("hipsLegsFeets").setValue(hipsLegsFeets)
}

}
