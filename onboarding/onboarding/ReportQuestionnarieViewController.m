//
//  ReportQuestionnarieViewController.m
//  onboarding
//
//  Created by Jorge Gomez on 2016-06-30.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

#import "ReportQuestionnarieViewController.h"
#import "FirebaseHelper.h"
#import "MXSegmentedPager.h"


@interface ReportQuestionnarieViewController () <MXSegmentedPagerDelegate, MXSegmentedPagerDataSource, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MXSegmentedPager  * segmentedPager;
@property (strong, nonatomic) UITableView *generalTableView;
@property (strong, nonatomic) UITableView *immuneTableView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end


@implementation ReportQuestionnarieViewController

NSArray *general;
NSArray *immune;
NSArray *gastrointestinal;

NSArray *segmentedPages;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.segmentedPager];
    self.segmentedPager.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedPager.segmentedControl.selectionIndicatorColor = [UIColor orangeColor];
    self.segmentedPager.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleBox;
    self.segmentedPager.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor orangeColor]};
    //self.segmentedPager.segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleDynamic;
  
    //self.segmentedPager.segmentedControl
    
  
  
  
    general = @[@"Diabetes",@"Hypoglycemia",@"Stress / Depression",@"Epilepsy / Seizures",@"Skin conditions / Rashes", @"Alcoholism", @"High Cholesterol"];
    immune = @[@"HIV(AIDS)",@"Pheumonia", @"Allergies / sinus troubles", @"Catch colds / flue Easily"];
    gastrointestinal = @[@"bla",@"ble",@"bli",@"blo"];
  
    segmentedPages = @[@"General",@"AAAA",@"BBB"];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    self.segmentedPager.frame = (CGRect){
        .origin.x       = 0.f,
        .origin.y       = 80.f,
        .size.width     = self.view.frame.size.width,
        .size.height    = self.view.frame.size.height - 80.f
    };
    [super viewWillLayoutSubviews];
}

#pragma -mark Properties

- (MXSegmentedPager *)segmentedPager {
    if (!_segmentedPager) {
        
        // Set a segmented pager
        _segmentedPager = [[MXSegmentedPager alloc] init];
        _segmentedPager.delegate    = self;
        _segmentedPager.dataSource  = self;
    }
    return _segmentedPager;
}

#pragma -mark <MXSegmentedPagerDelegate>

- (void)segmentedPager:(MXSegmentedPager *)segmentedPager didSelectViewWithTitle:(NSString *)title {
    NSLog(@"%@ page selected.", title);

}

#pragma -mark <MXSegmentedPagerDataSource>

- (NSInteger)numberOfPagesInSegmentedPager:(MXSegmentedPager *)segmentedPager {
    return 3;
}


- (NSString *)segmentedPager:(MXSegmentedPager *)segmentedPager titleForSectionAtIndex:(NSInteger)index {
    return [segmentedPages objectAtIndex:index];
}

- (UIView *)segmentedPager:(MXSegmentedPager *)segmentedPager viewForPageAtIndex:(NSInteger)index {
    return self.tableView;
}

#pragma -mark <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
}

#pragma -mark <UITableViewDataSource>

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return general.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
  
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
  
    cell.textLabel.text = general[indexPath.row];
  
    return cell;
}
- (IBAction)doneTapped:(id)sender {

  [self performSegueWithIdentifier:@"next6" sender:self];
}

@end
