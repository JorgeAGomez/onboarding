//
//  HealthCoverageViewController.m
//  onboarding
//
//  Created by Jorge Gomez on 2016-06-27.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

#import "HealthCoverageViewController.h"
#import "XLForm.h"
#import "FormViewController.h"
#import "ReportQuestionnarieViewController.h"
#import "ConditionsViewController.h"

@interface HealthCoverageViewController ()

@end

@implementation HealthCoverageViewController

#ifndef USE_PREDICATES_FOR_HIDING
  XLFormRowDescriptor * _insuranceCompany;

#endif

- (void)viewDidLoad {
  [super viewDidLoad];
  self.tableView.contentInset = UIEdgeInsetsMake(44,0,0,0);
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
    XLFormDescriptor *healthCoverageForm;
    XLFormSectionDescriptor *healthCoverageSection;
    XLFormRowDescriptor *healthCoverageRow;
  
    healthCoverageForm.assignFirstResponderOnShow = YES;
  
    healthCoverageForm = [XLFormDescriptor formDescriptorWithTitle:@"Extended Health Coverage"];
    healthCoverageSection = [XLFormSectionDescriptor formSection];
    healthCoverageSection.title = @"Extended Health Coverage Information (private or through work)";
    [healthCoverageForm addFormSection:healthCoverageSection];
  
    //Figure out if patient has health coverage
    healthCoverageRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Extended Health Coverage" rowType:XLFormRowDescriptorTypeSelectorSegmentedControl title:@"Do you have extended health coverage?"];
    healthCoverageRow.selectorOptions = @[@"Yes", @"No"];
    healthCoverageRow.value = @"No";
    [healthCoverageSection addFormRow:healthCoverageRow];
  
  
    healthCoverageRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Insurance Company" rowType:XLFormRowDescriptorTypeName title:@"Insurance Company:"];
    healthCoverageRow.required = YES;
    [healthCoverageRow.cellConfigAtConfigure setObject:@(NSTextAlignmentJustified) forKey:@"textField.textAlignment"];
    _insuranceCompany = healthCoverageRow;
  
  
    self.form = healthCoverageForm;
  
}

-(void)formRowDescriptorValueHasChanged:(XLFormRowDescriptor *)rowDescriptor oldValue:(id)oldValue newValue:(id)newValue
{
   [super formRowDescriptorValueHasChanged:rowDescriptor oldValue:oldValue newValue:newValue];
    if([rowDescriptor.tag isEqualToString:@"Extended Health Coverage"])
    {
      if([rowDescriptor.value isEqualToString:@"No"])
      {
        [self.form removeFormRowWithTag:@"Insurance Company"];
      }
      else
      {
        [self.form addFormRow:_insuranceCompany afterRow:rowDescriptor];
      }
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  ConditionsViewController *controller = [segue destinationViewController];
  controller.personalInformation = [NSDictionary dictionaryWithDictionary:_personalInformation];
  controller.medicalInformation = [NSDictionary dictionaryWithDictionary:_medicalInformation];
  controller.workInjuryInformation = [NSDictionary dictionaryWithDictionary:_workInjuryInformation];
  controller.motorVehicleInjuryInformation = [NSDictionary dictionaryWithDictionary:_motorVehicleInjuryInformation];
  controller.healthCoverageInformation = [NSDictionary dictionaryWithDictionary:_healthCoverageInformation];

}

- (IBAction)nextButton:(id)sender
{
  NSArray * validationErrors = [self formValidationErrors];
  if (validationErrors.count > 0){
      [self showFormValidationError:[validationErrors firstObject]];
      return;
  }
  _healthCoverageInformation = [self formValues];
  [self performSegueWithIdentifier:@"next4" sender:self];
}
@end
