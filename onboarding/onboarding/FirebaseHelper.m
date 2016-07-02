//
//  FirebaseHelper.m
//  onboarding
//
//  Created by Jorge Gomez on 2016-06-28.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

#import "FirebaseHelper.h"
@import Firebase;
@import FirebaseDatabase;
@import FirebaseAuth;

@interface FirebaseHelper ()

@end

@implementation FirebaseHelper

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}


+(void) savePatient:(NSString*)firstName :(NSString*)lastName :(NSString*)address :(NSString*)city :(NSString*)province :(NSString*)postalCode :(NSString*)homePhone :(NSString*)cellPhone :(NSString*)workPhone :(NSString *)dateOfBirth :(NSString*)PHNnumber :(NSString *)emergencyContact :(NSString*)contactPhone :(NSString*)medicalDoctorName :(NSString*)doctorPhone :(NSString*) doctorAddress
{
  
    //Referencing to the child "Messages"
    //FIRUser *current_user = [[FIRAuth auth] currentUser];
    FIRDatabaseReference *dbReference = [[[FIRDatabase database]reference] child:@"patientInformation"];
    
    //creates a unique ID for every new message created

    NSDictionary *newPatient = @{@"firstName": firstName,
                                 @"lastName": lastName,
                                 @"address": address,
                                 @"city": city,
                                 @"province": province,
                                 @"postalCode": postalCode,
                                 @"homePhone": homePhone,
                                 @"cellPhone": cellPhone,
                                 @"workPhone": workPhone,
                                 @"DOB": dateOfBirth,
                                 @"PHNnumber": PHNnumber,
                                 @"emergencyContact": emergencyContact,
                                 @"contactPhone":contactPhone,
                                 @"medicalDoctorName":medicalDoctorName,
                                 @"doctorPhone":doctorPhone,
                                 @"doctorAddress":doctorAddress,
                                };
    NSString *newPath = @"/";
    newPath = [newPath stringByAppendingString:@"a7Uzr64jhBNpEbCkOufUNRxHeZv1"];
    newPath = [newPath stringByAppendingString:@"/"];

    NSDictionary *addingPatient = @{newPath: newPatient };

    [dbReference updateChildValues:addingPatient];
}


+(void) workInjuryData:(NSString *)workInjury :(NSString *)dateOfInjury :(NSString *)WCBClaimNumber :(NSString *)employer :(NSString *)employerPhone :(NSString *)employerAddress :(NSString *)canContactEmployer
{
    if([workInjury isEqualToString:@"Yes"])
    {
    //Referencing to the child "Visit"
    // ******  Add reference to the current user logged in when integrating with Physio4D ***********
    FIRDatabaseReference *dbReference = [[[FIRDatabase database]reference] child:@"visit"];
    
    //creates a unique ID for every new message created

    NSDictionary *newWorkInjury = @{@"dateOfInjury": dateOfInjury,
                                 @"WCBClaimNumber": WCBClaimNumber,
                                 @"employer":employer,
                                 @"employerPhone": employerPhone,
                                 @"employerAddress":employerAddress,
                                 @"contactinEmployer":canContactEmployer
                                };
    NSString *newPath = @"/";
    newPath = [newPath stringByAppendingString:@"a7Uzr64jhBNpEbCkOufUNRxHeZv1"]; // --> Need to use real user ID
    newPath = [newPath stringByAppendingString:@"/workInjury"];

    NSDictionary *addingPatient = @{newPath: newWorkInjury };

    [dbReference updateChildValues:addingPatient];
    }
    else
    {
    FIRDatabaseReference *dbReference = [[[FIRDatabase database]reference] child:@"visit"];
    
    //creates a unique ID for every new message created

    NSDictionary *newWorkInjury = @{@"dateOfInjury": @"N/A",
                                 @"WCBClaimNumber": @"N/A",
                                 @"employer":@"N/A",
                                 @"employerPhone": @"N/A",
                                 @"employerAddress":@"N/A",
                                 @"contactinEmployer":@"N/A"
                                };
    NSString *newPath = @"/";
    newPath = [newPath stringByAppendingString:@"a7Uzr64jhBNpEbCkOufUNRxHeZv1"]; // --> Need to use real user ID
    newPath = [newPath stringByAppendingString:@"/workInjury"];

    NSDictionary *addingPatient = @{newPath: newWorkInjury };

    [dbReference updateChildValues:addingPatient];
    
    }
}

+(void) motorVehicleInjury:(NSString *)motorVehicleInjury :(NSString *)insuranceName :(NSString *)dateOfAccident :(NSString *)claimOrPolicy :(NSString *)adjuster :(NSString *)phoneNumber :(NSString *)fax :(NSString *)nameOnPolicy :(NSString *)legalRepresentative {
  
    if([motorVehicleInjury isEqualToString:@"Yes"]){
      FIRDatabaseReference *dbReference = [[[FIRDatabase database]reference] child:@"visit"];
      
      

      NSDictionary *newMotorAccident = @{@"insuranceName": insuranceName,
                                   @"dateOfAccident": dateOfAccident,
                                   @"claimpolicy":claimOrPolicy,
                                   @"adjuster": adjuster,
                                   @"phoneNumber":phoneNumber,
                                   @"fax":fax,
                                   @"nameOnPolicy":nameOnPolicy,
                                   @"legalRepresentative":legalRepresentative
                                  };
      NSString *newPath = @"/";
      newPath = [newPath stringByAppendingString:@"a7Uzr64jhBNpEbCkOufUNRxHeZv1"]; // --> Need to use real User ID!
      newPath = [newPath stringByAppendingString:@"/motorVehicleInjury"];

      NSDictionary *addingPatient = @{newPath: newMotorAccident };

      [dbReference updateChildValues:addingPatient];
    }
    else{
      FIRDatabaseReference *dbReference = [[[FIRDatabase database]reference] child:@"visit"];
      
      //creates a unique ID for every new message created

      NSDictionary *newMotorAccident = @{@"insuranceName": @"N/A",
                                   @"dateOfAccident": @"N/A",
                                   @"claimpolicy":@"N/A",
                                   @"adjuster": @"N/A",
                                   @"phoneNumber":@"N/A",
                                   @"fax":@"N/A",
                                   @"nameOnPolicy":@"N/A",
                                   @"legalRepresentative":@"N/A"
                                  };
      NSString *newPath = @"/";
      newPath = [newPath stringByAppendingString:@"a7Uzr64jhBNpEbCkOufUNRxHeZv1"];
      newPath = [newPath stringByAppendingString:@"/motorVehicleInjury"];

      NSDictionary *addingPatient = @{newPath: newMotorAccident };

      [dbReference updateChildValues:addingPatient];
    }
}

+(void) extendedHealthCoverage:(NSString *)extendedCoverage :(NSString *)insuranceName
{
  if([extendedCoverage isEqualToString:@"No"])
  {
    FIRDatabaseReference *dbReference = [[[FIRDatabase database]reference] child:@"visit"];
      
      //creates a unique ID for every new message created

      NSDictionary *newExtended = @{@"insuranceName": @"N/A" };
      NSString *newPath = @"/";
      newPath = [newPath stringByAppendingString:@"a7Uzr64jhBNpEbCkOufUNRxHeZv1"];
      newPath = [newPath stringByAppendingString:@"/extendedHealthCoverage"];

      NSDictionary *addingPatient = @{newPath: newExtended };

      [dbReference updateChildValues:addingPatient];
  }
  else{
    
    FIRDatabaseReference *dbReference = [[[FIRDatabase database]reference] child:@"visit"];
    //creates a unique ID for every new message created
    NSDictionary *newExtendedCoverage = @{ @"insuranceName":insuranceName };
    NSString *newPath = @"/";
    newPath = [newPath stringByAppendingString:@"a7Uzr64jhBNpEbCkOufUNRxHeZv1"];
    newPath = [newPath stringByAppendingString:@"/extendedHealthCoverage"];

    NSDictionary *addingPatient = @{newPath: newExtendedCoverage };

    [dbReference updateChildValues:addingPatient];
  }
}

@end
