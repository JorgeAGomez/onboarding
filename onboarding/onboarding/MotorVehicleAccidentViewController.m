//
//  MotorVehicleAccidentViewController.m
//  onboarding
//
//  Created by Jorge Gomez on 2016-06-27.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

#import "MotorVehicleAccidentViewController.h"
#import "XLForm.h"
#import "HealthCoverageViewController.h"
#import "SHSPhoneNumberFormatter+UserConfig.h"


@interface MotorVehicleAccidentViewController ()

@end

BOOL wentBack3 = false;
NSString *segmentedValue;
NSMutableDictionary *newValues;


@implementation MotorVehicleAccidentViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.tableView.contentInset = UIEdgeInsetsMake(44,0,0,0);
  newValues = [[NSMutableDictionary alloc] init];
}

-(void)viewWillDisappear:(BOOL)animated{
  [super viewWillDisappear:animated];
  _saveNewTextFieldValues = [[NSMutableDictionary alloc]init];
  if(self.isMovingFromParentViewController){
     for(id key in [self formValues]){
       if(![[[self formValues] objectForKey:key] isEqual:[NSNull null]]){
          if([[[self formValues] objectForKey:@"Motor Vehicle Injury"] isEqual:@"No"]){
            wentBack3 = false;
          }
          else{
            wentBack3 = true;
          }
          [_saveNewTextFieldValues setObject:[[self formValues] objectForKey:key] forKey:key];
       }
     }
     if(wentBack3){
      [[NSUserDefaults standardUserDefaults] setObject:_saveNewTextFieldValues forKey:@"motorVehicleAccident"];
     }
  }
}

#ifndef USE_PREDICATES_FOR_HIDING
  XLFormRowDescriptor * _insurance;
  XLFormRowDescriptor * _date;
  XLFormRowDescriptor * _claim;
  XLFormRowDescriptor * _adjuster;
  XLFormRowDescriptor * _phone;
  XLFormRowDescriptor * _fax;
  XLFormRowDescriptor * _policyName;
  XLFormRowDescriptor * _legalRepresentative;

#endif

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
    XLFormDescriptor *carAccidentForm;
    XLFormSectionDescriptor *carAccidentSection;
    XLFormRowDescriptor *carAccidentRow;
  
    newValues = [[[NSUserDefaults standardUserDefaults] objectForKey:@"motorVehicleAccident"] mutableCopy];
  
    carAccidentForm.assignFirstResponderOnShow = YES;
  
    carAccidentForm = [XLFormDescriptor formDescriptorWithTitle:@"Motor Vehicle Accident Information"];
    carAccidentSection = [XLFormSectionDescriptor formSection];
    carAccidentSection.title = @"Motor Vehicle Accident Information";
    [carAccidentForm addFormSection:carAccidentSection];
  
    //Figure out if is a work related injury.
    carAccidentRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Motor Vehicle Injury" rowType:XLFormRowDescriptorTypeSelectorSegmentedControl title:@"Are you here due to a motor vehicle accident?"];
    carAccidentRow.selectorOptions = @[@"Yes", @"No"];
    if(wentBack3){
      segmentedValue = [newValues objectForKey:@"Motor Vehicle Injury"];
      if([segmentedValue isEqual:@"Yes"]){
        segmentedValue = @"Yes";
      }
      else{
        segmentedValue = @"No";
      }
    }
    else{
      segmentedValue = @"No";
    }
    carAccidentRow.value = segmentedValue;
    [carAccidentSection addFormRow:carAccidentRow];
  
  
    carAccidentRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Insurence" rowType:XLFormRowDescriptorTypeName title:@"* Insurance Company:"];
    [carAccidentRow.cellConfigAtConfigure setObject:@(NSTextAlignmentJustified) forKey:@"textField.textAlignment"];
    carAccidentRow.required = YES;
    if(wentBack3){
      NSString *insurance = [newValues objectForKey:@"Insurence"];
      if([insurance isEqual:[NSNull null]]){
        insurance = @"";
      }
      carAccidentRow.value = insurance;
      [carAccidentSection addFormRow:carAccidentRow];
    }
    _insurance = carAccidentRow;
  
    //Date of accident
    carAccidentRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Date of accident" rowType:XLFormRowDescriptorTypeDateInline title:@"Date of accident:"];
    if(wentBack3){
      NSDate *dateOfAccident = [newValues objectForKey:@"Date of accident"];
      if([dateOfAccident isEqual:[NSNull null]]){
        dateOfAccident = [NSDate date];
      }
      carAccidentRow.value = dateOfAccident;
      [carAccidentSection addFormRow:carAccidentRow];
    }
    _date = carAccidentRow;
  
    //Claim / Policy number
    carAccidentRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Claim/Policy #" rowType:XLFormRowDescriptorTypeNumber title:@"Claim/Policy #:"];
    [carAccidentRow.cellConfigAtConfigure setObject:@(NSTextAlignmentJustified) forKey:@"textField.textAlignment"];
    if(wentBack3){
      NSString *claim = [newValues objectForKey:@"Claim/Policy #"];
      if([claim isEqual:[NSNull null]]){
        claim = @"";
      }
      carAccidentRow.value = claim;
      [carAccidentSection addFormRow:carAccidentRow];
    }
    _claim = carAccidentRow;
  
    //Adjuster
    carAccidentRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Adjuster" rowType:XLFormRowDescriptorTypeName title:@"Adjuster Name:"];
    [carAccidentRow.cellConfigAtConfigure setObject:@(NSTextAlignmentJustified) forKey:@"textField.textAlignment"];
    if(wentBack3){
      NSString *adjuster = [newValues objectForKey:@"Adjuster"];
      if([adjuster isEqual:[NSNull null]]){
        adjuster = @"";
      }
      carAccidentRow.value = adjuster;
      [carAccidentSection addFormRow:carAccidentRow];
    }
    _adjuster = carAccidentRow;
  
    //Phone No.
    SHSPhoneNumberFormatter *formatter = [[SHSPhoneNumberFormatter alloc] init];
    [formatter setDefaultOutputPattern:@"(###) ###-####" imagePath:nil];
    carAccidentRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Phone No." rowType:XLFormRowDescriptorTypePhone title:@"Phone #:"];
    carAccidentRow.valueFormatter = formatter;
    carAccidentRow.useValueFormatterDuringInput = YES;
    [carAccidentRow.cellConfigAtConfigure setObject:@(NSTextAlignmentJustified) forKey:@"textField.textAlignment"];
    if(wentBack3){
      NSString *phoneNumber = [newValues objectForKey:@"Phone No."];
      if([phoneNumber isEqual:[NSNull null]]){
        phoneNumber = @"";
      }
      carAccidentRow.value = phoneNumber;
      [carAccidentSection addFormRow:carAccidentRow];
    }
    _phone = carAccidentRow;
  
    //Fax #
    carAccidentRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Fax #" rowType:XLFormRowDescriptorTypePhone title:@"Fax #:"];
    [carAccidentRow.cellConfigAtConfigure setObject:@(NSTextAlignmentJustified) forKey:@"textField.textAlignment"];
    carAccidentRow.valueFormatter = formatter;
    carAccidentRow.useValueFormatterDuringInput = YES;
    if(wentBack3){
      NSString *fax = [newValues objectForKey:@"Fax #"];
      if([fax isEqual:[NSNull null]]){
        fax = @"";
      }
      carAccidentRow.value = fax;
      [carAccidentSection addFormRow:carAccidentRow];
    }
    _fax = carAccidentRow;
  
    //Name on Policy
    carAccidentRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Name on Policy" rowType:XLFormRowDescriptorTypeName title:@"Name on Policy:"];
    [carAccidentRow.cellConfigAtConfigure setObject:@(NSTextAlignmentJustified) forKey:@"textField.textAlignment"];
    if(wentBack3){
      NSString *policy = [newValues objectForKey:@"Name on Policy"];
      if([policy isEqual:[NSNull null]]){
        policy = @"";
      }
      carAccidentRow.value = policy;
      [carAccidentSection addFormRow:carAccidentRow];
    }
    _policyName = carAccidentRow;
  
    //Legal Representative(if applicable)
    carAccidentRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Legal Representative" rowType:XLFormRowDescriptorTypeText title:@"Legal Representative (if applicable):"];
    [carAccidentRow.cellConfigAtConfigure setObject:@(NSTextAlignmentJustified) forKey:@"textField.textAlignment"];
    if(wentBack3){
      NSString *representative = [newValues objectForKey:@"Legal Representative"];
      if([representative isEqual:[NSNull null]]){
        representative = @"";
      }
      carAccidentRow.value = representative;
      [carAccidentSection addFormRow:carAccidentRow];
    }
    _legalRepresentative = carAccidentRow;

    self.form = carAccidentForm;
  
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if([segue.identifier isEqualToString:@"next3"]){
    HealthCoverageViewController *controller = [segue destinationViewController];
    controller.personalInformation = [NSMutableDictionary dictionaryWithDictionary:_personalInformation];
    controller.medicalInformation = [NSMutableDictionary dictionaryWithDictionary:_medicalInformation];
    controller.workInjuryInformation = [NSMutableDictionary dictionaryWithDictionary:_workInjuryInformation];
    controller.motorVehicleInjuryInformation = [NSMutableDictionary dictionaryWithDictionary:_motorVehicleInjuryInformation];
    
  }
}

-(void)formRowDescriptorValueHasChanged:(XLFormRowDescriptor *)rowDescriptor oldValue:(id)oldValue newValue:(id)newValue
{
   [super formRowDescriptorValueHasChanged:rowDescriptor oldValue:oldValue newValue:newValue];
    if([rowDescriptor.tag isEqualToString:@"Motor Vehicle Injury"])
    {
      if([rowDescriptor.value isEqualToString:@"No"])
      {
        [self.form removeFormRowWithTag:@"Insurence"];
        [self.form removeFormRowWithTag:@"Date of accident"];
        [self.form removeFormRowWithTag:@"Claim/Policy #"];
        [self.form removeFormRowWithTag:@"Adjuster"];
        [self.form removeFormRowWithTag:@"Phone No."];
        [self.form removeFormRowWithTag:@"Fax #"];
        [self.form removeFormRowWithTag:@"Name on Policy"];
        [self.form removeFormRowWithTag:@"Legal Representative"];
      }
      else
      {
        [self.form addFormRow:_insurance afterRow:rowDescriptor];
        [self.form addFormRow:_date afterRow:_insurance];
        [self.form addFormRow:_claim afterRow:_date];
        [self.form addFormRow:_adjuster afterRow:_claim];
        [self.form addFormRow:_phone afterRow:_adjuster];
        [self.form addFormRow:_fax afterRow:_phone];
        [self.form addFormRow:_policyName afterRow:_fax];
        [self.form addFormRow:_legalRepresentative afterRow:_policyName];
      }
    }
}

- (IBAction)nextButton:(id)sender {
    NSArray * validationErrors = [self formValidationErrors];
    if (validationErrors.count > 0){
        [self showFormValidationError:[validationErrors firstObject]];
      
        return;
    }

  _motorVehicleInjuryInformation = [NSMutableDictionary dictionaryWithDictionary:[self formValues]];
  
  if([_motorVehicleInjuryInformation[@"Claim/Policy #"] isEqual:[NSNull null]])
  {
      UIAlertController * alert=   [UIAlertController
                                     alertControllerWithTitle:@"Reminder"
                                     message:@"Please provide the Claim/Policy # in your next visit. Thanks."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
       UIAlertAction* ok = [UIAlertAction
                            actionWithTitle:@"OK"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action)
                            {
                                [self performSegueWithIdentifier:@"next3" sender:self];

                            }];
        
       [alert addAction:ok];
        
       [self presentViewController:alert animated:YES completion:nil];
  }
  [self performSegueWithIdentifier:@"next3" sender:self];
}
@end
