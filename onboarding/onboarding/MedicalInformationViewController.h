//
//  MedicalInformationViewController.h
//  onboarding
//
//  Created by Jorge Gomez on 2016-06-26.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

#import "XLFormViewController.h"

@interface MedicalInformationViewController : XLFormViewController

- (IBAction)nextButton:(id)sender;
@property (strong,nonatomic) NSDictionary *personalInformation;
@property (strong, nonatomic) NSDictionary *medicalInformation;

@end
