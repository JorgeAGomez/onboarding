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

static func medicalInformation(emergencyContact: String, emergencyPhoneNumber: String, medicalDoctorName: String, doctorPhoneNumber: String, address: String){
  let dbReference = FIRDatabase.database().reference()
  dbReference.child("patientInformation").child("\(homePhoneId)\(cellPhoneId)\(workPhoneId)\(nameId)").child("medicalInformation").setValue(["emergencyContact":emergencyContact,
                                                                                                                                             "emergencyPhoneNumber":emergencyPhoneNumber,
                                                                                                                                             "medicalDoctorName":medicalDoctorName,
                                                                                                                                             "doctorPhoneNumber":doctorPhoneNumber,
                                                                                                                                             "address":address])
}

static func workRelatedInjury(dateOfInjury: NSDate, WCBClaimNumber: String, employer: String, employerPhoneNumber: String, address: String, mayContactEmployer:String){
  let dbReference = FIRDatabase.database().reference()
  let dateFormatter = NSDateFormatter()
  dateFormatter.dateFormat = "yyyy-MM-dd"
  let stringDate = dateFormatter.stringFromDate(dateOfInjury)
  dbReference.child("patientInformation").child("\(homePhoneId)\(cellPhoneId)\(workPhoneId)\(nameId)").child("workRelatedInjury").setValue(["dateOfInjury":stringDate,
                                                                                                                                            "WCBClainNumber":WCBClaimNumber,
                                                                                                                                            "employer":employer,
                                                                                                                                            "employerPhone":employerPhoneNumber,
                                                                                                                                            "address":address,
                                                                                                                                            "mayContactEmployer":mayContactEmployer])
}

static func motorVehicleAccident(insuranceCompany: String, dateOfAccident: NSDate, claimPolicyNumber: String, adjuster: String, phoneNumber: String, faxNumber: String, nameOnPolicy: String, legalRepresentative: String){
  let dbReference = FIRDatabase.database().reference()
  let dateFormatter = NSDateFormatter()
  dateFormatter.dateFormat = "yyyy-MM-dd"
  let stringDate = dateFormatter.stringFromDate(dateOfAccident)
  dbReference.child("patientInformation").child("\(homePhoneId)\(cellPhoneId)\(workPhoneId)\(nameId)").child("motorVehicleAccident").setValue(["insuranceCompany":insuranceCompany,
                                                                                                                                               "dateOfAccident":stringDate,
                                                                                                                                               "claimPolicyNumber":claimPolicyNumber,
                                                                                                                                               "adjuster":adjuster,
                                                                                                                                               "phoneNumber":phoneNumber,
                                                                                                                                               "faxNumber":faxNumber,
                                                                                                                                               "nameOnPolicy":nameOnPolicy,
                                                                                                                                               "legalRepresentative":legalRepresentative])
}

static func healthCoverage(){

}

}