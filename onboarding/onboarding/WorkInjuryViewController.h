//
//  WorkInjuryViewController.h
//  onboarding
//
//  Created by Jorge Gomez on 2016-06-27.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

#import "XLFormViewController.h"

@interface MedicalNavigationViewController : UINavigationController

@end

@interface WorkInjuryViewController : XLFormViewController
- (IBAction)nextButton:(id)sender;
@property (strong,nonatomic) NSDictionary *personalInformation;
@property (strong, nonatomic) NSDictionary *medicalInformation;
@property (strong,nonatomic) NSDictionary *workInjuryInformation;

@end
