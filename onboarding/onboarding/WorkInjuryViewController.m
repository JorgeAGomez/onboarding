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

#import "SHSPhoneNumberFormatter+UserConfig.h"

@interface WorkInjuryViewController ()

@end

BOOL wentBack2 = false;
NSString *yesOrNo;
NSString *yesOrNo2;
NSMutableDictionary *retrieveDictionary;

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
  retrieveDictionary = [[NSMutableDictionary alloc]init];
}

-(void)viewWillDisappear:(BOOL)animated{
  [super viewWillDisappear:animated];
  _saveTextFieldValues = [[NSMutableDictionary alloc]init];
  if(self.isMovingFromParentViewController){
     for(id key in [self formValues]){
       if(![[[self formValues] objectForKey:key] isEqual:[NSNull null]]){
          if([[[self formValues] objectForKey:@"Work Related Injury"] isEqual:@"No"]){
            wentBack2 = false;
          }
          else{
            wentBack2 = true;
          }
          [_saveTextFieldValues setObject:[[self formValues] objectForKey:key] forKey:key];
       }
     }
     if(wentBack2){
      [[NSUserDefaults standardUserDefaults] setObject:_saveTextFieldValues forKey:@"workRelatedInjury"];
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
    XLFormDescriptor *workInjuryForm;
    XLFormSectionDescriptor *workInjurySection;
    XLFormRowDescriptor *workInjuryRow;
  
    retrieveDictionary = [[[NSUserDefaults standardUserDefaults] objectForKey:@"workRelatedInjury"] mutableCopy];
  
    workInjuryForm.assignFirstResponderOnShow = YES;
  
    workInjuryForm = [XLFormDescriptor formDescriptorWithTitle:@"Work Related Injury Information"];
    workInjurySection = [XLFormSectionDescriptor formSection];
    workInjurySection.title = @"Work Related Injury Information";
    [workInjuryForm addFormSection:workInjurySection];
  
    //Figure out if is a work related injury.
    workInjuryRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Work Related Injury" rowType:XLFormRowDescriptorTypeSelectorSegmentedControl title:@"Are you here due to work related injury?"];
    workInjuryRow.selectorOptions = @[@"Yes", @"No"];
    if(wentBack2){
      yesOrNo = [retrieveDictionary objectForKey:@"Work Related Injury"];
      if([yesOrNo isEqual:@"Yes"]){
        yesOrNo = @"Yes";
      }
      else{
        yesOrNo = @"No";
      }
    }
    else{
      yesOrNo = @"No";
    }
    workInjuryRow.value = yesOrNo;
    [workInjurySection addFormRow:workInjuryRow];
  
    //Date of Injury
    workInjuryRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Date of Injury" rowType:XLFormRowDescriptorTypeDateInline title:@"* Date of Injury:"];
    if(wentBack2){
      NSDate *dateOfInjury = [retrieveDictionary objectForKey:@"Date of Injury"];
      if([dateOfInjury isEqual:[NSNull null]]){
        dateOfInjury = [NSDate date];
      }
      workInjuryRow.value = dateOfInjury;
      [workInjurySection addFormRow:workInjuryRow];
    }
    workInjuryRow.required = YES;
    _dateOfInjury = workInjuryRow;
  
    //WCB Claim Number --> NOT required but need to be provided ASAP
    workInjuryRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"WCB Claim No." rowType:XLFormRowDescriptorTypeText title:@"WCB Claim #:"];
    [workInjuryRow.cellConfigAtConfigure setObject:@(NSTextAlignmentJustified) forKey:@"textField.textAlignment"];
    if(wentBack2){
      NSString *WCBClaim = [retrieveDictionary objectForKey:@"WCB Claim No."];
      if([WCBClaim isEqual:[NSNull null]]){
        WCBClaim = @"";
      }
      workInjuryRow.value = WCBClaim;
      [workInjurySection addFormRow:workInjuryRow];
    }
    _WCBClaim = workInjuryRow;
  
    //Employer
    workInjuryRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Employer" rowType:XLFormRowDescriptorTypeName title:@"* Employer:"];
    [workInjuryRow.cellConfigAtConfigure setObject:@(NSTextAlignmentJustified) forKey:@"textField.textAlignment"];
    workInjuryRow.required = YES;
    if(wentBack2){
      NSString *employer = [retrieveDictionary objectForKey:@"Employer"];
      if([employer isEqual:[NSNull null]]){
        employer = @"";
      }
      workInjuryRow.value = employer;
      [workInjurySection addFormRow:workInjuryRow];
    }
    _Employer = workInjuryRow;
  
    //Phone number
    SHSPhoneNumberFormatter *formatter = [[SHSPhoneNumberFormatter alloc] init];
    [formatter setDefaultOutputPattern:@"(###) ###-####" imagePath:nil];
    workInjuryRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Employer Phone" rowType:XLFormRowDescriptorTypePhone title:@"Employer Phone #:"];
    [workInjuryRow.cellConfigAtConfigure setObject:@(NSTextAlignmentJustified) forKey:@"textField.textAlignment"];
    workInjuryRow.valueFormatter = formatter;
    workInjuryRow.useValueFormatterDuringInput = YES;
    if(wentBack2){
      NSString *employerPhone = [retrieveDictionary objectForKey:@"Employer Phone"];
      if([employerPhone isEqual:[NSNull null]]){
        employerPhone = @"";
      }
      workInjuryRow.value = employerPhone;
      [workInjurySection addFormRow:workInjuryRow];
    }
    _Phone = workInjuryRow;
  
    //Address
    workInjuryRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Employer Address" rowType:XLFormRowDescriptorTypeText title:@"Address:"];
    [workInjuryRow.cellConfigAtConfigure setObject:@(NSTextAlignmentJustified) forKey:@"textField.textAlignment"];
    if(wentBack2){
      NSString *address = [retrieveDictionary objectForKey:@"Employer Address"];
      if([address isEqual:[NSNull null]]){
        address = @"";
      }
      workInjuryRow.value = address;
      [workInjurySection addFormRow:workInjuryRow];
    }
    _Address = workInjuryRow;
  
    //Can we contact the employer?
    workInjuryRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Contact employer" rowType:XLFormRowDescriptorTypeSelectorSegmentedControl title:@"May we contact your employer?"];
    workInjuryRow.selectorOptions = @[@"Yes", @"No"];
    if(wentBack2){
      yesOrNo2 = [retrieveDictionary objectForKey:@"Work Related Injury"];
      if([yesOrNo2 isEqual:@"Yes"]){
        yesOrNo2 = @"Yes";
        [workInjurySection addFormRow:workInjuryRow];
      }
      else{
        yesOrNo2 = @"No";
        [workInjurySection addFormRow:workInjuryRow];
      }
    }
    else{
      yesOrNo2 = @"No";
    }
    workInjuryRow.value = yesOrNo2;
    _contactEmployer = workInjuryRow;
  
    self.form = workInjuryForm;
  
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if([segue.identifier isEqualToString:@"next2"]){
    MotorVehicleAccidentViewController *controller = [segue destinationViewController];
    controller.personalInformation = [NSMutableDictionary dictionaryWithDictionary:_personalInformation];
    controller.medicalInformation = [NSMutableDictionary dictionaryWithDictionary:_medicalInformation];
    controller.workInjuryInformation = [NSMutableDictionary dictionaryWithDictionary:_workInjuryInformation];
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
    NSArray * validationErrors = [self formValidationErrors];
    if (validationErrors.count > 0){
        [self showFormValidationError:[validationErrors firstObject]];
      
        return;
    }
    _workInjuryInformation = [NSMutableDictionary dictionaryWithDictionary:[self formValues]];
  
    if([_workInjuryInformation[@"WCB Claim No."] isEqual:[NSNull null]])
    {
      UIAlertController * alert=   [UIAlertController
                                     alertControllerWithTitle:@"Reminder"
                                     message:@"WCB claim No. is not required but it needs to be provided when possible."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
       UIAlertAction* ok = [UIAlertAction
                            actionWithTitle:@"OK"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action)
                            {
                                [self performSegueWithIdentifier:@"next2" sender:self];

                            }];
        
       [alert addAction:ok];
        
       [self presentViewController:alert animated:YES completion:nil];

    }
    [self performSegueWithIdentifier:@"next2" sender:self];
}
@end
