//
//  HealthCoverageViewController.h
//  onboarding
//
//  Created by Jorge Gomez on 2016-06-27.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

#import "XLFormViewController.h"

@interface MedicalNavigationViewController : UINavigationController

@end

@interface HealthCoverageViewController : XLFormViewController

@property (strong,nonatomic) NSMutableDictionary *personalInformation;
@property (strong, nonatomic) NSMutableDictionary *medicalInformation;
@property (strong,nonatomic) NSMutableDictionary *workInjuryInformation;
@property (strong,nonatomic) NSMutableDictionary *motorVehicleInjuryInformation;
@property (strong, nonatomic) NSMutableDictionary *healthCoverageInformation;

@property (strong, nonatomic) NSMutableDictionary *otherValuesTextField;

- (IBAction)nextButton:(id)sender;



@end
