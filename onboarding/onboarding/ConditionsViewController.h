//
//  ConditionsViewController.h
//  onboarding
//
//  Created by Jorge Gomez on 2016-07-05.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

#import "XLFormViewController.h"

@interface ConditionsViewController : XLFormViewController

@property (strong,nonatomic) NSDictionary *personalInformation;
@property (strong, nonatomic) NSDictionary *medicalInformation;
@property (strong,nonatomic) NSDictionary *workInjuryInformation;
@property (strong,nonatomic) NSDictionary *motorVehicleInjuryInformation;
@property (strong, nonatomic) NSDictionary *healthCoverageInformation;
@property (strong, nonatomic) NSDictionary *conditionsInformation;


@end
