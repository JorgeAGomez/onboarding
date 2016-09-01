//
//  MedicalInformationViewController.m
//  onboarding
//
//  Created by Jorge Gomez on 2016-06-26.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

#import "MedicalInformationViewController.h"
#import "XLForm.h"
#import "DateAndTimeValueTransformer.h"
#import "WorkInjuryViewController.h"
#import <SHSPhoneComponent/SHSPhoneNumberFormatter+UserConfig.h>


@interface MedicalInformationViewController ()

@end

BOOL wentBack = false;

@implementation MedicalInformationViewController

-(void)viewDidLoad{
  [super viewDidLoad];
  self.tableView.contentInset = UIEdgeInsetsMake(44,0,0,0);

}

-(void)viewWillDisappear:(BOOL)animated{
  [super viewWillDisappear:animated];
  _checkPreviousValues = [[NSMutableDictionary alloc]init];
  if(self.isMovingFromParentViewController){
     for(id key in [self formValues]){
       if(![[[self formValues] objectForKey:key] isEqual:[NSNull null]]){
          wentBack = true;
          NSString *value = [[self formValues] objectForKey:key];
          [_checkPreviousValues setObject:value forKey:key];
       }
     }
     if(wentBack){
      [[NSUserDefaults standardUserDefaults] setObject:_checkPreviousValues forKey:@"medicalInformation"];
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
    XLFormDescriptor *medicalInfoForm;
    XLFormSectionDescriptor *medicallInfoSection;
    XLFormRowDescriptor *medicalInfoRow;
    NSDictionary *retrieveDictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"medicalInformation"];
  
    medicalInfoForm.assignFirstResponderOnShow = YES;
  
    medicalInfoForm = [XLFormDescriptor formDescriptorWithTitle:@"Medical Information"];
    medicallInfoSection = [XLFormSectionDescriptor formSection];
    medicallInfoSection.title = @"Medical Information";
    [medicalInfoForm addFormSection:medicallInfoSection];
  
    //Emergency contact
    medicalInfoRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Emergency Contact" rowType:XLFormRowDescriptorTypeName title:@"* Emergency Contact Name:"];
    [medicalInfoRow.cellConfigAtConfigure setObject:@(NSTextAlignmentJustified) forKey:@"textField.textAlignment"];
    medicalInfoRow.required = YES;
    if(wentBack){
      NSString *emergencyContactValue = [retrieveDictionary objectForKey:@"Emergency Contact"];
      if([emergencyContactValue isEqual:[NSNull null]]){
        emergencyContactValue = @"";
      }
      medicalInfoRow.value = emergencyContactValue;
    }
  
    [medicallInfoSection addFormRow:medicalInfoRow];
  
    //Emergency contact Phone No.
    SHSPhoneNumberFormatter *formatter = [[SHSPhoneNumberFormatter alloc] init];
    [formatter setDefaultOutputPattern:@"(###) ###-####" imagePath:nil];
    medicalInfoRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Contact Phone" rowType:
    XLFormRowDescriptorTypePhone title:@"* Emergency Contact Phone #:"];
    medicalInfoRow.valueFormatter = formatter;
    [medicalInfoRow.cellConfigAtConfigure setObject:@(NSTextAlignmentJustified) forKey:@"textField.textAlignment"];
    medicalInfoRow.useValueFormatterDuringInput = YES;
    if(wentBack){
      NSString *contactNumber = [retrieveDictionary objectForKey:@"Contact Phone"];
      if([contactNumber isEqual:[NSNull null]]){
      contactNumber = @"";
      }
      medicalInfoRow.value = contactNumber;
    }
    medicalInfoRow.required = YES;
    [medicallInfoSection addFormRow:medicalInfoRow];
  
    //Medical Doctor's Name
    medicalInfoRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Medical Doctor's Name" rowType:XLFormRowDescriptorTypeName title:@"Medical Doctor's Name:"];
    [medicalInfoRow.cellConfigAtConfigure setObject:@(NSTextAlignmentJustified) forKey:@"textField.textAlignment"];
    if(wentBack){
      NSString *doctorName = [retrieveDictionary objectForKey:@"Medical Doctor's Name"];
      if([doctorName isEqual:[NSNull null]]){
        doctorName = @"";
      }
      medicalInfoRow.value = doctorName;
    }
    [medicallInfoSection addFormRow:medicalInfoRow];
  
        //Emergency contact Phone No.
    medicalInfoRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Doctor Phone" rowType:XLFormRowDescriptorTypePhone title:@"Doctor Phone #:"];
    medicalInfoRow.valueFormatter = formatter;
    medicalInfoRow.useValueFormatterDuringInput = YES;
    [medicalInfoRow.cellConfigAtConfigure setObject:@(NSTextAlignmentJustified) forKey:@"textField.textAlignment"];
    if(wentBack){
      NSString *doctorPhone = [retrieveDictionary objectForKey:@"Doctor Phone"];
      if([doctorPhone isEqual:[NSNull null]]){
        doctorPhone = @"";
      }
      medicalInfoRow.value = doctorPhone;
    }
    [medicallInfoSection addFormRow:medicalInfoRow];
  
    //Address
    medicalInfoRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Address" rowType:XLFormRowDescriptorTypeText title:@"Address:"];
    [medicalInfoRow.cellConfigAtConfigure setObject:@(NSTextAlignmentJustified) forKey:@"textField.textAlignment"];
    if(wentBack){
    NSString *address = [retrieveDictionary objectForKey:@"Address"];
    if([address isEqual:[NSNull null]]){
      address = @"";
    }
    medicalInfoRow.value = address;
    }
    [medicallInfoSection addFormRow:medicalInfoRow];
    self.form = medicalInfoForm;
    
}

-(NSDictionary *)formValues{

  NSMutableDictionary * result = [NSMutableDictionary dictionary];
  for (XLFormSectionDescriptor * section in self.form.formSections) {
     if (!section.isMultivaluedSection){
         for (XLFormRowDescriptor * row in section.formRows){
             if (row.tag && ![row.tag isEqualToString:@""]){
                 [result setObject:(row.value ?: [NSNull null]) forKey:row.tag];
             }
             NSLog(@"%@",row.tag);
         }
     }
     else{
         NSMutableArray * multiValuedValuesArray = [NSMutableArray new];
         for (XLFormRowDescriptor * row in section.formRows) {
             if (row.value){
                 [multiValuedValuesArray addObject:row.value];
             }
         }
         [result setObject:multiValuedValuesArray forKey:section.multivaluedTag];
     }
 }

 return result;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"next1"]){
      WorkInjuryViewController *controller = [segue destinationViewController];
      controller.personalInformation = [NSMutableDictionary dictionaryWithDictionary:_personalInformation];
      controller.medicalInformation = [NSMutableDictionary dictionaryWithDictionary:_medicalInformation];
    }
}


- (IBAction)nextButton:(id)sender {
  NSArray * validationErrors = [self formValidationErrors];
  if (validationErrors.count > 0){
      [self showFormValidationError:[validationErrors firstObject]];
      return;
  }
  _medicalInformation = [NSMutableDictionary dictionaryWithDictionary:[self formValues]];
  
  if([_medicalInformation[@"Medical Doctor's Name"] isEqual:[NSNull null]])
  {
      UIAlertController * alert=   [UIAlertController
                                     alertControllerWithTitle:@"Reminder"
                                     message:@"Provide Medical Doctor's Name as soon as possible"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
       UIAlertAction* ok = [UIAlertAction
                            actionWithTitle:@"OK"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action)
                            {
                              [self performSegueWithIdentifier:@"next1" sender:self];
                                 
                            }];
        
       [alert addAction:ok];
        
       [self presentViewController:alert animated:YES completion:nil];
  }
  
  else
  {
    [self performSegueWithIdentifier:@"next1" sender:self];
  }
  

  
}
@end
