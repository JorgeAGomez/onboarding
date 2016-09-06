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
#import "ConditionsViewController.h"

@interface HealthCoverageViewController ()

@end

BOOL wentBack4 = false;
NSString *newSegmented;
NSMutableDictionary *theNewTextFieldValues;

@implementation HealthCoverageViewController

#ifndef USE_PREDICATES_FOR_HIDING
  XLFormRowDescriptor * _insuranceCompany;

#endif

- (void)viewDidLoad {
  [super viewDidLoad];
  self.tableView.contentInset = UIEdgeInsetsMake(44,0,0,0);
  theNewTextFieldValues = [[NSMutableDictionary alloc]init];
}

-(void)viewWillDisappear:(BOOL)animated{
  [super viewWillDisappear:animated];
  theNewTextFieldValues = [[NSMutableDictionary alloc]init];
  if(self.isMovingFromParentViewController){
     for(id key in [self formValues]){
       if(![[[self formValues] objectForKey:key] isEqual:[NSNull null]]){
          if([[[self formValues] objectForKey:@"Extended Health Coverage"] isEqual:@"No"]){
            wentBack4 = false;
          }
          else{
            wentBack4 = true;
          }
          [theNewTextFieldValues setObject:[[self formValues] objectForKey:key] forKey:key];
       }
     }
     if(wentBack4){
      [[NSUserDefaults standardUserDefaults] setObject:theNewTextFieldValues forKey:@"extendedHealthCoverage"];
     }
  }
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
  
    theNewTextFieldValues = [[[NSUserDefaults standardUserDefaults] objectForKey:@"extendedHealthCoverage"] mutableCopy];
  
    healthCoverageForm.assignFirstResponderOnShow = YES;
  
    healthCoverageForm = [XLFormDescriptor formDescriptorWithTitle:@"Extended Health Coverage"];
    healthCoverageSection = [XLFormSectionDescriptor formSection];
    healthCoverageSection.title = @"Extended Health Coverage Information (private or through work)";
    [healthCoverageForm addFormSection:healthCoverageSection];
  
    //Figure out if patient has health coverage
    healthCoverageRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Extended Health Coverage" rowType:XLFormRowDescriptorTypeSelectorSegmentedControl title:@"Do you have extended health coverage?"];
    healthCoverageRow.selectorOptions = @[@"Yes", @"No"];
   if(wentBack4){
      newSegmented = [theNewTextFieldValues objectForKey:@"extendedHealthCoverage"];
      if([newSegmented isEqual:@"Yes"]){
        newSegmented = @"Yes";
      }
      else{
        newSegmented = @"No";
      }
    }
    else{
      newSegmented = @"No";
    }

    healthCoverageRow.value = newSegmented;
    [healthCoverageSection addFormRow:healthCoverageRow];
  
  
    healthCoverageRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Insurance Company" rowType:XLFormRowDescriptorTypeName title:@"* Insurance Company:"];
    healthCoverageRow.required = YES;
    [healthCoverageRow.cellConfigAtConfigure setObject:@(NSTextAlignmentJustified) forKey:@"textField.textAlignment"];
    if(wentBack4){
      NSString *insuranceName = [theNewTextFieldValues objectForKey:@"Insurance Company"];
      if([insuranceName isEqual:[NSNull null]]){
        insuranceName = @"";
      }
      healthCoverageRow.value = insuranceName;
      [healthCoverageSection addFormRow:healthCoverageRow];
    }
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
  controller.personalInformation = [NSMutableDictionary dictionaryWithDictionary:_personalInformation];
  controller.medicalInformation = [NSMutableDictionary dictionaryWithDictionary:_medicalInformation];
  controller.workInjuryInformation = [NSMutableDictionary dictionaryWithDictionary:_workInjuryInformation];
  controller.motorVehicleInjuryInformation = [NSMutableDictionary dictionaryWithDictionary:_motorVehicleInjuryInformation];
  controller.healthCoverageInformation = [NSMutableDictionary dictionaryWithDictionary:_healthCoverageInformation];

}

- (IBAction)nextButton:(id)sender
{
  NSArray * validationErrors = [self formValidationErrors];
  if (validationErrors.count > 0){
      [self showFormValidationError:[validationErrors firstObject]];
      return;
  }
  _healthCoverageInformation = [NSMutableDictionary dictionaryWithDictionary:[self formValues]];
  [self performSegueWithIdentifier:@"next4" sender:self];
}
@end
