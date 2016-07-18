//
//  ConditionsViewController.m
//  onboarding
//
//  Created by Jorge Gomez on 2016-07-05.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

#import "ConditionsViewController.h"

@interface ConditionsViewController ()

@end

@implementation ConditionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"Phone type"
                                 message:@"Select you Choice"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
  
  UIAlertAction* homePhone = [UIAlertAction
                        actionWithTitle:@"Home #"
                        style:UIAlertActionStyleDefault
                        handler:^(UIAlertAction * action)
                        {
                          //Do some thing here
                          [view dismissViewControllerAnimated:YES completion:nil];}];
  
    UIAlertAction* workPhone = [UIAlertAction
                        actionWithTitle:@"Home #"
                        style:UIAlertActionStyleDefault
                        handler:^(UIAlertAction * action)
                        {
                          //Do some thing here
                          [view dismissViewControllerAnimated:YES completion:nil];}];
  
  
  [view addAction:homePhone];
  [view addAction:workPhone];
  [self presentViewController:view animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
