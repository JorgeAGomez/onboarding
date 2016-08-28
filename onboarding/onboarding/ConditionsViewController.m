//
//  ConditionsViewController.m
//  onboarding
//
//  Created by Jorge Gomez on 2016-07-05.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

#import "ConditionsViewController.h"
#import "XLForm.h"
#import "onboarding-Swift.h"

@interface ConditionsViewController ()

@property (nonatomic,strong) QuestionnarieVC *questionnarie;

@end

@implementation ConditionsViewController

XLFormRowDescriptor *allergiesChecked;
XLFormRowDescriptor *allergiesNewCell;

XLFormRowDescriptor *medicationChecked;
XLFormRowDescriptor *medicationNewCell;



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(30,0,0,0);
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

    XLFormDescriptor *conditionsForm;
    XLFormSectionDescriptor *conditionsSection;
    XLFormRowDescriptor *conditionsRow;
  
    conditionsForm.assignFirstResponderOnShow = YES;
  
    conditionsForm = [XLFormDescriptor formDescriptorWithTitle:@"Conditions"];
    conditionsSection = [XLFormSectionDescriptor formSection];
    conditionsSection.title = @"Check off any following conditions that you may be experiencing:";
    [conditionsForm addFormSection:conditionsSection];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Neck Pain / stiffness" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Neck Pain / stiffness";
    [conditionsSection addFormRow:conditionsRow];
  
        conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Arthritis in neck" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Arthritis in neck";
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Headaches" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Headaches";
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Jaw Pain / TMJ" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Jaw Pain / TMJ";
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Diabetes" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Diabetes";
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Shoulder Pain" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Shoulder Pain";
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Pain in elbows / wrists / hand" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Pain in elbows / wrists / hand";
    [conditionsSection addFormRow:conditionsRow];

    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Pain in hips / knees / ankles" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Pain in hips / knees / ankles";
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Arthritis in limbs" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Arthritis in limbs";
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Skin conditions/Rashes" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Skin conditions / Rashes";
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Mid back Pain" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Mid back Pain";
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Muscle cramps / spasms" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Muscle cramps / spasms";
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Carpal Tunnel" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Carpal Tunnel";
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Swelling feet / hands" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Swelling feet / hands";
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Anemia/Fatigue" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Anemia / Fatigue";
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Low Back Pain / stiffness" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Low Back Pain / stiffness";
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Tailbone pain" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Tailbone pain";
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Numbness/tingling in legs / feet" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Numbness / tingling in legs / feet";
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Numbness/tingling in arms / hands" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Numbness / tingling in arms / hands";
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Dizziness" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Dizziness";
    [conditionsSection addFormRow:conditionsRow];
  
    //conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Allergies" rowType:XLFormRowDescriptorTypeBooleanCheck];
    //conditionsRow.title = @"Do you have any allergies?";
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Allergies" rowType:XLFormRowDescriptorTypeSelectorSegmentedControl title:@"Do you have allergies?"];
    conditionsRow.selectorOptions = @[@"Yes", @"No"];
    conditionsRow.value = @"No";
    [conditionsSection addFormRow:conditionsRow];
    allergiesChecked = conditionsRow;
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Medications" rowType:XLFormRowDescriptorTypeSelectorSegmentedControl title:@"Are you taking medications?"];
    conditionsRow.selectorOptions = @[@"Yes", @"No"];
    conditionsRow.value = @"No";
    [conditionsSection addFormRow:conditionsRow];
    medicationChecked = conditionsRow;
  
    conditionsSection = [XLFormSectionDescriptor formSection];
    [conditionsForm addFormSection:conditionsSection];
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Notes" rowType:XLFormRowDescriptorTypeTextView title:@"Notes"];
    [conditionsSection addFormRow:conditionsRow];
  
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"AllergiesText" rowType:XLFormRowDescriptorTypeText];
    [conditionsRow.cellConfigAtConfigure setObject:@"Please list all your allergies here..." forKey:@"textField.placeholder"];
    conditionsRow.required = YES;
    allergiesNewCell = conditionsRow;
  
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"MedicationsText" rowType:XLFormRowDescriptorTypeText];
    [conditionsRow.cellConfigAtConfigure setObject:@"Please list any medications you are currently taken..." forKey:@"textField.placeholder"];
    conditionsRow.required = YES;
    medicationNewCell = conditionsRow;

  
  
    self.form = conditionsForm;

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//  _questionnarie = [[QuestionnarieVC alloc] init];
//  _questionnarie = [segue destinationViewController];
//  
//  _questionnarie.personalInformation = [NSMutableDictionary dictionaryWithDictionary:_personalInformation];
//  _questionnarie.medicalInformation = [NSMutableDictionary dictionaryWithDictionary:_medicalInformation];
//  _questionnarie.workInjuryInformation = [NSMutableDictionary dictionaryWithDictionary:_workInjuryInformation];
//  _questionnarie.motorVehicleInjuryInformation = [NSMutableDictionary dictionaryWithDictionary:_motorVehicleInjuryInformation];
//  _questionnarie.healthCoverageInformation = [NSMutableDictionary dictionaryWithDictionary:_healthCoverageInformation];
//  _questionnarie.conditionsInformation = [NSMutableDictionary dictionaryWithDictionary:_conditionsInformation];
}

-(void)formRowDescriptorValueHasChanged:(XLFormRowDescriptor *)rowDescriptor oldValue:(id)oldValue newValue:(id)newValue
{
  [super formRowDescriptorValueHasChanged:rowDescriptor oldValue:oldValue newValue:newValue];
  //checks if allergies cell has been tapped
  if([rowDescriptor.tag isEqualToString:@"Allergies"])
  {
    if([newValue isEqualToString:@"Yes"])
    {
        //if cell is checked add new cell
        [self.form addFormRow:allergiesNewCell afterRow:allergiesChecked];
    }
    else
    {
        //remove the new cell
        [self.form removeFormRow:allergiesNewCell];
    }
  }
  //check if medication cell has been tapped
  if([rowDescriptor.tag isEqualToString:@"Medications"])
  {
    
    if([newValue isEqualToString:@"Yes"])
    {
      [self.form addFormRow:medicationNewCell afterRow:medicationChecked];
    }
    else
    {
      [self.form removeFormRow:medicationNewCell];
    }
  }
}
- (IBAction)nextTapped:(id)sender {
  NSArray * validationErrors = [self formValidationErrors];
  if (validationErrors.count > 0)
  {
      [self showFormValidationError:[validationErrors firstObject]];
      return;
  }
  _conditionsInformation = [NSMutableDictionary dictionaryWithDictionary:[self formValues]];;
  
  if(![_conditionsInformation[@"Allergies"] isEqualToString:@"No"])
  {
    NSString *allegiesValue = [_conditionsInformation valueForKey:@"AllergiesText"];
    [_conditionsInformation setValue:allegiesValue forKey:@"Allergies"];
    [_conditionsInformation setValue:nil forKey:@"AllergiesText"];
  }
  
  if(![_conditionsInformation[@"Medications"] isEqualToString:@"No"]){
    NSString *medicationsValue = [_conditionsInformation valueForKey:@"MedicationsText"];
    [_conditionsInformation setValue:medicationsValue forKey:@"Medications"];
    [_conditionsInformation setValue:nil forKey:@"MedicationsText"];
  }
  

//  
//  _questionnarie = [[QuestionnarieVC alloc] init];
//  _questionnarie.personalInformation = [NSMutableDictionary dictionaryWithDictionary:_personalInformation];
//  _questionnarie.medicalInformation = [NSMutableDictionary dictionaryWithDictionary:_medicalInformation];
//  _questionnarie.workInjuryInformation = [NSMutableDictionary dictionaryWithDictionary:_workInjuryInformation];
//  _questionnarie.motorVehicleInjuryInformation = [NSMutableDictionary dictionaryWithDictionary:_motorVehicleInjuryInformation];
//  _questionnarie.healthCoverageInformation = [NSMutableDictionary dictionaryWithDictionary:_healthCoverageInformation];
//  _questionnarie.conditionsInformation = [NSMutableDictionary dictionaryWithDictionary:_conditionsInformation];
//  
//  [self.navigationController pushViewController:_questionnarie animated:true];
  
  [self performSegueWithIdentifier:@"gogo" sender:self];
  
  
}

@end
