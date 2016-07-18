//
//  FormViewController.m
//  onboarding
//
//  Created by Jorge Gomez on 2016-06-26.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

#import "FormViewController.h"
#import "XLForm.h"
#import "DateAndTimeValueTransformer.h"
#import "MedicalInformationViewController.h"
#import "LeftSelectorRightTextField.h"
#import <SHSPhoneComponent/SHSPhoneNumberFormatter+UserConfig.h>


@interface FormViewController ()

@end

@implementation FormViewController

-(void)viewDidLoad
{
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
    XLFormDescriptor *personalInformationForm;
    XLFormSectionDescriptor *personalInformationSection;
    XLFormRowDescriptor *personalInformationRow;
  
    //personalInformationForm.assignFirstResponderOnShow = YES;
  
    personalInformationForm = [XLFormDescriptor formDescriptorWithTitle:@"Personal Information"];
    personalInformationSection = [XLFormSectionDescriptor formSection];
    personalInformationSection.title = @"Personal Information";
    [personalInformationForm addFormSection:personalInformationSection];
  
    //First name
    personalInformationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"First name" rowType:XLFormRowDescriptorTypeName title:@"First name"];
    personalInformationRow.required = YES;
    [personalInformationRow.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [personalInformationSection addFormRow:personalInformationRow];
  
    //Last name
    personalInformationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Last name" rowType:XLFormRowDescriptorTypeName title:@"Last name"];
    personalInformationRow.required = YES;
    [personalInformationRow.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [personalInformationSection
    
      addFormRow:personalInformationRow];
  
    // Address
    personalInformationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Address" rowType:XLFormRowDescriptorTypeText title:@"Address"];
    [personalInformationRow.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    personalInformationRow.required = YES;
    [personalInformationSection addFormRow:personalInformationRow];
  
    //City
    personalInformationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"City" rowType:XLFormRowDescriptorTypeText title:@"City"];
    personalInformationRow.value = @"Calgary";
    personalInformationRow.required = YES;
    [personalInformationRow.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [personalInformationSection addFormRow:personalInformationRow];
  
    //Province
    personalInformationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Province" rowType:XLFormRowDescriptorTypeSelectorPush title:@"Province"];
    personalInformationRow.value = [XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"Alberta"];

    personalInformationRow.selectorTitle = @"Province";
    personalInformationRow.selectorOptions =
                          @[[XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"Alberta"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"British Columbia"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"Ontario"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(3) displayText:@"Northwest Territories"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(4) displayText:@"Quebec"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(6) displayText:@"Nunavut"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(7) displayText:@"Prince Edward Island"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(8) displayText:@"Nova Scotia"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(9) displayText:@"New Brunswick"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(10) displayText:@"Newfoundland and Labrador"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(11) displayText:@"Yukon"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(12) displayText:@"Manitoba"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(13) displayText:@"Saskatchewan"],
                            ];

    personalInformationRow.required = YES;
    [personalInformationSection addFormRow:personalInformationRow];
  
    //Postal Code
    personalInformationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Postal Code" rowType:XLFormRowDescriptorTypeText title:@"Postal Code"];
    [personalInformationRow.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    personalInformationRow.required = YES;
    [personalInformationSection addFormRow:personalInformationRow];
  
    //Select type of Home Phone #
    SHSPhoneNumberFormatter *formatter = [[SHSPhoneNumberFormatter alloc] init];
    [formatter setDefaultOutputPattern:@"(###) ###-####" imagePath:nil];
    personalInformationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Home Phone #" rowType:XLFormRowDescriptorTypePhone title:@"Home Phone #"];
    personalInformationRow.valueFormatter = formatter;
    [personalInformationRow.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    personalInformationRow.useValueFormatterDuringInput = YES;
    [personalInformationSection addFormRow:personalInformationRow];
  
        //Select type of Cell Phone #
    personalInformationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Cell Phone #" rowType:XLFormRowDescriptorTypePhone title:@"Cell Phone #"];
    personalInformationRow.valueFormatter = formatter;
    [personalInformationRow.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    personalInformationRow.useValueFormatterDuringInput = YES;
    [personalInformationSection addFormRow:personalInformationRow];
  
        //Select type of  Work Phone #
    personalInformationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Work Phone #" rowType:XLFormRowDescriptorTypePhone title:@"Work Phone #"];
    personalInformationRow.valueFormatter = formatter;
    [personalInformationRow.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    personalInformationRow.useValueFormatterDuringInput = YES;
    [personalInformationSection addFormRow:personalInformationRow];

    //Date of Birth
    personalInformationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Date of Birth" rowType:XLFormRowDescriptorTypeDateInline title:@"Date of Birth"];
    personalInformationRow.value = [NSDate new];
    personalInformationRow.required = YES;
    [personalInformationSection addFormRow:personalInformationRow];
  
    //PHN #
    personalInformationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"PHN No." rowType:XLFormRowDescriptorTypeText title:@"PHN No."];
    //No, but remember patient to provide it ASAP
    [personalInformationRow.cellConfigAtConfigure setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [personalInformationRow.cellConfigAtConfigure setObject:@"12345-6789" forKey:@"textField.placeholder"];
    [personalInformationSection addFormRow:personalInformationRow];
    
    self.form = personalInformationForm;
  
}

-(NSDictionary *)formValues{

  NSMutableDictionary * result = [NSMutableDictionary dictionary];
  for (XLFormSectionDescriptor * section in self.form.formSections) {
     if (!section.isMultivaluedSection){
         for (XLFormRowDescriptor * row in section.formRows) {
             if (row.tag && ![row.tag isEqualToString:@""]){
                 [result setObject:(row.value ?: [NSNull null]) forKey:row.tag];
             }
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
  
  //PASS dictionary with personal Info!!
  if([segue.identifier isEqualToString:@"next"]){
    MedicalInformationViewController *controller = [segue destinationViewController];
    controller.personalInformation = [NSDictionary dictionaryWithDictionary:_personalDictionary];
  }
}

#pragma mark - XLFormDescriptorDelegate

- (IBAction)nextButton:(id)sender {
    NSArray * validationErrors = [self formValidationErrors];
    if (validationErrors.count > 0){
        [self showFormValidationError:[validationErrors firstObject]];
      
        return;
    }
    _personalDictionary = [self formValues];
  
    //Makes sure at least one phone is given
    if([_personalDictionary[@"Home Phone #"] isEqual:[NSNull null]] && [_personalDictionary[@"Cell Phone #"] isEqual:[NSNull null]] && [_personalDictionary[@"Work Phone #"] isEqual:[NSNull null]])
    {
        UIAlertController * alert=   [UIAlertController
                                       alertControllerWithTitle:@"Error"
                                       message:@"Provide at least one phone number"
                                       preferredStyle:UIAlertControllerStyleAlert];
          
         UIAlertAction* ok = [UIAlertAction
                              actionWithTitle:@"OK"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  [alert dismissViewControllerAnimated:YES completion:nil];
                                   
                              }];
          
         [alert addAction:ok];
          
         [self presentViewController:alert animated:YES completion:nil];
    }
    else{
      if([_personalDictionary[@"PHN No."] isEqual:[NSNull null]])
      {
          UIAlertController * alert=   [UIAlertController
                                 alertControllerWithTitle:@"Reminder"
                                 message:@"Please provide your PHN when possible"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
          UIAlertAction* ok = [UIAlertAction
                        actionWithTitle:@"OK"
                        style:UIAlertActionStyleDefault
                        handler:^(UIAlertAction * action)
                        {
                            [self.tableView endEditing:YES];
                            [self performSegueWithIdentifier:@"next" sender:self];
                        }];
    
          [alert addAction:ok];
          [self presentViewController:alert animated:YES completion:nil];
      }
    }
}

- (IBAction)cancelPressed:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}
@end
