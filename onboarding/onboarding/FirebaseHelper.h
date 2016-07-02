//
//  FirebaseHelper.h
//  onboarding
//
//  Created by Jorge Gomez on 2016-06-28.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirebaseHelper : UIViewController


//Save new patient
+(void) savePatient:(NSString*)firstName :(NSString*)lastName :(NSString*)address :(NSString*)city :(NSString*)province :(NSString*)postalCode :(NSString*)homePhone :(NSString*)cellPhone :(NSString*)workPhone :(NSString *)dateOfBirth :(NSString*)PHNnumber :(NSString*)emergencyContact :(NSString*)contactPhone :(NSString*)medicalDoctorName :(NSString*)doctorPhone :(NSString*) doctorAddress;

//work Injury
+(void) workInjuryData:(NSString *)workInjury :(NSString *)dateOfInjury :(NSString *)WCBClaimNumber :(NSString *)employer :(NSString *)employerPhone :(NSString *)employerAddress :(NSString *)canContactEmployer;

//motor vehicle injury
+(void) motorVehicleInjury:(NSString *)motorVehicleInjury :(NSString *)insuranceName :(NSString *)dateOfAccident :(NSString *)claimOrPolicy :(NSString *)adjuster :(NSString *)phoneNumber :(NSString *)fax :(NSString *)nameOnPolicy :(NSString *)legalRepresentative;


+(void) extendedHealthCoverage:(NSString *)extendedCoverage :(NSString *)insuranceName;
@end
