//
//  ConsentIntroViewController.m
//
//
//  Created by Jorge Gomez on 2016-07-29.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

#import "ConsentIntroViewController.h"

@interface ConsentIntroViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@end

@implementation ConsentIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    _startButton.layer.borderWidth = 1;
    _startButton.layer.borderColor = _startButton.tintColor.CGColor;
    _startButton.layer.cornerRadius = 6;
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
