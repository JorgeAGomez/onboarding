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
    XLFormSectionDescriptor *personalInfomartionSection;
    XLFormRowDescriptor *personalInformationRow;
  
    //personalInformationForm.assignFirstResponderOnShow = YES;
  
    personalInformationForm = [XLFormDescriptor formDescriptorWithTitle:@"Personal Information"];
    personalInfomartionSection = [XLFormSectionDescriptor formSection];
    personalInfomartionSection.title = @"Personal Information";
    [personalInformationForm addFormSection:personalInfomartionSection];
  
    //First name
    personalInformationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"First name" rowType:XLFormRowDescriptorTypeText title:@"First name"];
    //personalInformationRow.required = YES;

    [personalInfomartionSection addFormRow:personalInformationRow];
  
    //Last name
    personalInformationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Last name" rowType:XLFormRowDescriptorTypeText title:@"Last name"];
    //personalInformationRow.required = YES;
    [personalInfomartionSection addFormRow:personalInformationRow];
  
    // Address
    personalInformationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Address" rowType:XLFormRowDescriptorTypeText title:@"Address"];
    //personalInformationRow.required = YES;
    [personalInfomartionSection addFormRow:personalInformationRow];
  
    //City
    personalInformationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"City" rowType:XLFormRowDescriptorTypeText title:@"City"];
    //personalInformationRow.required = YES;
    [personalInfomartionSection addFormRow:personalInformationRow];
  
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

    //personalInformationRow.required = YES;
    [personalInfomartionSection addFormRow:personalInformationRow];
  
    //Postal Code
    personalInformationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Postal Code" rowType:XLFormRowDescriptorTypeText title:@"Postal Code"];
    //personalInformationRow.required = YES;
    [personalInfomartionSection addFormRow:personalInformationRow];

  
    //Home phone
    personalInformationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Home Phone #" rowType:XLFormRowDescriptorTypeText title:@"Home Phone #"];
  
    [personalInfomartionSection addFormRow:personalInformationRow];

    //Cell phone
    personalInformationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Cell Phone #" rowType:XLFormRowDescriptorTypeText title:@"Cell Phone #"];
  
    [personalInfomartionSection addFormRow:personalInformationRow];
  
    //Work phone
    personalInformationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Work Phone #" rowType:XLFormRowDescriptorTypeText title:@"Work Phone #"];
    [personalInfomartionSection addFormRow:personalInformationRow];


    //Date of Birth
    personalInformationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Date of Birth" rowType:XLFormRowDescriptorTypeDateInline title:@"Date of Birth"];
    personalInformationRow.value = [NSDate new];
    //personalInformationRow.required = YES;
    [personalInfomartionSection addFormRow:personalInformationRow];
  
    //PHN #
    personalInformationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"PHN No." rowType:XLFormRowDescriptorTypeText title:@"PHN No."];
    //REquired?????
    [personalInfomartionSection addFormRow:personalInformationRow];

    
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
  
    [self.tableView endEditing:YES];
  
    [self performSegueWithIdentifier:@"next" sender:self];
}

- (IBAction)cancelPressed:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}
@end
