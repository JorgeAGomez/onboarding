//
//  ReportQuestionnarieViewController.h
//  onboarding
//
//  Created by Jorge Gomez on 2016-06-30.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//


#import "XLFormViewController.h"

@interface ReportQuestionnarieViewController : XLFormViewController
@property (strong,nonatomic) NSDictionary *personalInformation;
@property (strong, nonatomic) NSDictionary *medicalInformation;
@property (strong,nonatomic) NSDictionary *workInjuryInformation;
@property (strong,nonatomic) NSDictionary *motorVehicleInjuryInformation;
@property (strong, nonatomic) NSDictionary *healthCoverageInformation;
@property (strong,nonatomic) NSDictionary *reportQuestionnarieInformation;

- (IBAction)doneButton:(id)sender;

@end
