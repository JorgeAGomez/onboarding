//
//  WorkInjuryViewController.m
//  onboarding
//
//  Created by Jorge Gomez on 2016-06-27.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

#import "WorkInjuryViewController.h"
#import "XLForm.h"
#import "MotorVehicleAccidentViewController.h"

@interface WorkInjuryViewController ()

@end

@implementation WorkInjuryViewController
#ifndef USE_PREDICATES_FOR_HIDING
    XLFormRowDescriptor * _dateOfInjury;
    XLFormRowDescriptor * _WCBClaim;
    XLFormRowDescriptor * _Employer;
    XLFormRowDescriptor * _Phone;
    XLFormRowDescriptor * _Address;
    XLFormRowDescriptor * _contactEmployer;
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
    XLFormDescriptor *workInjuryForm;
    XLFormSectionDescriptor *workInjurySection;
    XLFormRowDescriptor *workInjuryRow;
  
    workInjuryForm.assignFirstResponderOnShow = YES;
  
    workInjuryForm = [XLFormDescriptor formDescriptorWithTitle:@"Work Injury"];
    workInjurySection = [XLFormSectionDescriptor formSection];
    workInjurySection.title = @"Work Injury";
    [workInjuryForm addFormSection:workInjurySection];
  
    //Figure out if is a work related injury.
    workInjuryRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Work Related Injury" rowType:XLFormRowDescriptorTypeSelectorSegmentedControl title:@"Are you here due to work related injury?"];
    workInjuryRow.selectorOptions = @[@"Yes", @"No"];
    workInjuryRow.value = @"Yes";
    [workInjurySection addFormRow:workInjuryRow];
  
    //Date of Injury
    workInjuryRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Date of Injury" rowType:XLFormRowDescriptorTypeDateInline title:@"Date of Injury"];
    workInjuryRow.value = [NSDate date];
    workInjuryRow.required = YES;
    [workInjurySection addFormRow:workInjuryRow];
    _dateOfInjury = workInjuryRow;
  
    //WCB Claim Number
    workInjuryRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"WCB Claim No." rowType:XLFormRowDescriptorTypeText title:@"WCB Claim No."];
    workInjuryRow.required = YES;
    [workInjurySection addFormRow:workInjuryRow];
    _WCBClaim = workInjuryRow;
  
    //Employer
    workInjuryRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Employer" rowType:XLFormRowDescriptorTypeText title:@"Employer"];
    workInjuryRow.required = YES;
    [workInjurySection addFormRow:workInjuryRow];
    _Employer = workInjuryRow;
  
    //Phone number
    workInjuryRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Employer Phone" rowType:XLFormRowDescriptorTypeText title:@"Phone No."];
    [workInjurySection addFormRow:workInjuryRow];
    workInjuryRow.required = YES;
    _Phone = workInjuryRow;
  
    //Address
    workInjuryRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Employer Address" rowType:XLFormRowDescriptorTypeText title:@"Address"];
    workInjuryRow.required = YES;
    [workInjurySection addFormRow:workInjuryRow];
    _Address = workInjuryRow;
  
    //Can we contact the employer?
    workInjuryRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Contact employer" rowType:XLFormRowDescriptorTypeSelectorSegmentedControl title:@"May we contact your employer?"];
    workInjuryRow.selectorOptions = @[@"Yes", @"No"];
    workInjuryRow.value = @"Yes";
    [workInjurySection addFormRow:workInjuryRow];
    _contactEmployer = workInjuryRow;
  
    self.form = workInjuryForm;
  
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if([segue.identifier isEqualToString:@"next2"]){
    MotorVehicleAccidentViewController *controller = [segue destinationViewController];
    controller.personalInformation = [NSDictionary dictionaryWithDictionary:_personalInformation];
    controller.medicalInformation = [NSDictionary dictionaryWithDictionary:_medicalInformation];
    controller.workInjuryInformation = [NSDictionary dictionaryWithDictionary:_workInjuryInformation];
  }
}

-(void)formRowDescriptorValueHasChanged:(XLFormRowDescriptor *)rowDescriptor oldValue:(id)oldValue newValue:(id)newValue
{
   [super formRowDescriptorValueHasChanged:rowDescriptor oldValue:oldValue newValue:newValue];
    if ([rowDescriptor.tag isEqualToString:@"Work Related Injury"])
    {
      if ([rowDescriptor.value isEqualToString:@"No"])
      {
        [self.form removeFormRowWithTag:@"Date of Injury"];
        [self.form removeFormRowWithTag:@"WCB Claim No."];
        [self.form removeFormRowWithTag:@"Employer"];
        [self.form removeFormRowWithTag:@"Employer Phone"];
        [self.form removeFormRowWithTag:@"Employer Address"];
        [self.form removeFormRowWithTag:@"Contact employer"];
      }
      else
      {
        [self.form addFormRow:_dateOfInjury afterRow:rowDescriptor];
        [self.form addFormRow:_WCBClaim afterRow:_dateOfInjury];
        [self.form addFormRow:_Employer afterRow:_WCBClaim];
        [self.form addFormRow:_Phone afterRow:_Employer];
        [self.form addFormRow:_Address afterRow:_Phone];
        [self.form addFormRow:_contactEmployer afterRow:_Address];
      }
    }
}

- (IBAction)nextButton:(id)sender {
  
    _workInjuryInformation = [self formValues];
    [self performSegueWithIdentifier:@"next2" sender:self];
}
@end