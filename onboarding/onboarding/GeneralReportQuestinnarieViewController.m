//
//  GeneralReportQuestinnarieViewController.m
//  onboarding
//
//  Created by Jorge Gomez on 2016-07-04.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

#import "GeneralReportQuestinnarieViewController.h"
#import "XLForm.h"

@interface GeneralReportQuestinnarieViewController ()

@end

@implementation GeneralReportQuestinnarieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeForm];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initializeForm];
    }
    return self;
}

- (void)initializeForm
{



}


@end
