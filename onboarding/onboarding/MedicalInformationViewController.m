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


@interface MedicalInformationViewController ()

@end


@implementation MedicalInformationViewController

-(void)viewDidLoad{
  [super viewDidLoad];
  self.tableView.contentInset = UIEdgeInsetsMake(44,0,0,0);
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
  
    medicalInfoForm.assignFirstResponderOnShow = YES;
  
    medicalInfoForm = [XLFormDescriptor formDescriptorWithTitle:@"Medical Information"];
    medicallInfoSection = [XLFormSectionDescriptor formSection];
    medicallInfoSection.title = @"Medical Information";
    [medicalInfoForm addFormSection:medicallInfoSection];
  
    //Emergency contact
    medicalInfoRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Emergency Contact" rowType:XLFormRowDescriptorTypeText title:@"Emergency Contact"];
    //medicalInfoRow.required = YES;
    [medicallInfoSection addFormRow:medicalInfoRow];
  
    //Emergency contact Phone No.
    medicalInfoRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Contact Phone" rowType:XLFormRowDescriptorTypeText title:@"Contact Phone"];
    //personalInformationRow.required = YES;
    [medicallInfoSection addFormRow:medicalInfoRow];
  
    //Medical Doctor's Name
    medicalInfoRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Medical Doctor's Name" rowType:XLFormRowDescriptorTypeText title:@"Medical Doctor's Name"];
    //personalInformationRow.required = YES;
    [medicallInfoSection addFormRow:medicalInfoRow];
  
        //Emergency contact Phone No.
    medicalInfoRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Doctor Phone" rowType:XLFormRowDescriptorTypeText title:@"Doctor Phone"];
    //personalInformationRow.required = YES;
    [medicallInfoSection addFormRow:medicalInfoRow];
  
    //Address
    medicalInfoRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Address" rowType:XLFormRowDescriptorTypeText title:@"Address"];
    //personalInformationRow.required = YES;
    [medicallInfoSection addFormRow:medicalInfoRow];
  
    self.form = medicalInfoForm;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"next1"]){
      WorkInjuryViewController *controller = [segue destinationViewController];
      controller.personalInformation = [NSDictionary dictionaryWithDictionary:_personalInformation];
      controller.medicalInformation = [NSDictionary dictionaryWithDictionary:_medicalInformation];
    }
}


- (IBAction)nextButton:(id)sender {
  NSArray * validationErrors = [self formValidationErrors];
  if (validationErrors.count > 0){
      [self showFormValidationError:[validationErrors firstObject]];
      return;
  }
  _medicalInformation = [self formValues];
  [self performSegueWithIdentifier:@"next1" sender:self];
}
@end
