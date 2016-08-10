//
//  AssessmentAndTreatmentViewController.m
//  onboarding
//
//  Created by Jorge Gomez on 2016-07-05.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

#import "AssessmentAndTreatmentViewController.h"

@interface AssessmentAndTreatmentViewController ()
@property (weak, nonatomic) IBOutlet UITextField *assessmentInitialsTextField;


@end

@implementation AssessmentAndTreatmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)viewDidDisappear:(BOOL)animated{
  //treatmentInitials = _assessmentInitialsTextField.text;
}


- (IBAction)agreeTapped:(id)sender {
  if([_assessmentInitialsTextField.text isEqualToString:@""])
  {
         UIAlertController * alert=   [UIAlertController
                                     alertControllerWithTitle:@"Sorry"
                                     message:@"Initials are mandatory to agree with the assessment and treatment consent."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
       UIAlertAction* ok = [UIAlertAction
                            actionWithTitle:@"OK"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action)
                            {
                                [alert dismissViewControllerAnimated:YES completion:nil];
                            }];
        
       [alert addAction:ok];
        
       [self presentViewController:alert animated:YES completion:nil];

  }
  else{
    [self performSegueWithIdentifier:@"agree1" sender:self];
  }
}

@end
