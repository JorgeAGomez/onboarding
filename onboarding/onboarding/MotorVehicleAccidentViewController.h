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
@property (strong,nonatomic) NSMutableDictionary *personalInformation;
@property (strong, nonatomic) NSMutableDictionary *medicalInformation;
@property (strong,nonatomic) NSMutableDictionary *workInjuryInformation;
@property (strong,nonatomic) NSMutableDictionary *motorVehicleInjuryInformation;
@end
