//  ReleaseCollectConsentViewController.m
//  onboarding
//
//  Created by Jorge Gomez on 2016-07-05.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

#import "ReleaseCollectConsentViewController.h"
#import <ResearchKit/ResearchKit.h>

@interface ReleaseCollectConsentViewController ()
@property (weak, nonatomic) IBOutlet UITextField *collectInfoInitialsTextField;

@end

@implementation ReleaseCollectConsentViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)agreeTapped:(id)sender {
  if([_collectInfoInitialsTextField.text isEqualToString:@""])
  {
      UIAlertController * alert=   [UIAlertController
                                     alertControllerWithTitle:@"Sorry"
                                     message:@"Initials are mandatory to agree with the release and/or collect medical information consent."
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
    [self performSegueWithIdentifier:@"agree2" sender:self];
  }
}


@end
