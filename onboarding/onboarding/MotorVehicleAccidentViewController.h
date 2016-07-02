//
//  MotorVehicleAccidentViewController.h
//  onboarding
//
//  Created by Jorge Gomez on 2016-06-27.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

#import "XLFormViewController.h"


@interface MotorVehicleAccidentViewController : XLFormViewController

- (IBAction)nextButton:(id)sender;
@property (strong,nonatomic) NSDictionary *personalInformation;
@property (strong, nonatomic) NSDictionary *medicalInformation;
@property (strong,nonatomic) NSDictionary *workInjuryInformation;
@property (strong,nonatomic) NSDictionary *motorVehicleInjuryInformation;
@end
