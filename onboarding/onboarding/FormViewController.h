//
//  FormViewController.h
//  onboarding
//
//  Created by Jorge Gomez on 2016-06-26.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

#import "XLFormViewController.h"

@interface FormNavigationViewController : UINavigationController

@end

@interface FormViewController : XLFormViewController


@property (strong, nonatomic) NSMutableDictionary *personalInformation;

- (IBAction)nextButton:(id)sender;


@end
