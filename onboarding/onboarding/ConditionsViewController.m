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

@property (nonatomic,strong) GeneralTableViewController *questionnarie;
//@property (nonatomic,strong) AssessmentTreatmentVC *controller;

@end

BOOL wentBack5 = false;
BOOL wentBack6 = false;
BOOL wentBack7 = false;
NSString *activeOrNo;
NSString *newConditionSelection;
NSMutableDictionary *previousConditionsSelected;


@implementation ConditionsViewController

XLFormRowDescriptor *allergiesChecked;
XLFormRowDescriptor *allergiesNewCell;

XLFormRowDescriptor *medicationChecked;
XLFormRowDescriptor *medicationNewCell;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(30,0,0,0);
    previousConditionsSelected = [[NSMutableDictionary alloc]init];
}

-(void)viewWillDisappear:(BOOL)animated{
  [super viewWillDisappear:animated];
  previousConditionsSelected = [[NSMutableDictionary alloc]init];
  if(self.isMovingFromParentViewController){
     for(id key in [self formValues])
     {
        if(![[[self formValues] objectForKey:key] isEqual:[NSNull null]])
        {
          wentBack5 = true;
          NSString *value = [[self formValues] objectForKey:key];
          [previousConditionsSelected setObject:value forKey:key];
        }
        if([[[self formValues] objectForKey:@"Allergies"] isEqual:@"No"])
        {
          wentBack6 = false;
        }
        else{
          wentBack6 = true;
        }
        if([[[self formValues] objectForKey:@"Medications"] isEqual:@"No"]){
          wentBack7 = false;
        }
        else{
          wentBack7 = true;
        }
        
     }
     if(wentBack5)
     {
      [[NSUserDefaults standardUserDefaults] setObject:previousConditionsSelected forKey:@"conditions"];
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

    XLFormDescriptor *conditionsForm;
    XLFormSectionDescriptor *conditionsSection;
    XLFormRowDescriptor *conditionsRow;
  
  
    previousConditionsSelected = [[[NSUserDefaults standardUserDefaults] objectForKey:@"conditions"] mutableCopy];
    conditionsForm.assignFirstResponderOnShow = YES;
  
    conditionsForm = [XLFormDescriptor formDescriptorWithTitle:@"Conditions"];
    conditionsSection = [XLFormSectionDescriptor formSection];
    conditionsSection.title = @"Check off any of the following conditions that you may be experiencing:";
    [conditionsForm addFormSection:conditionsSection];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Neck Pain / stiffness" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Neck Pain / stiffness";
    if(wentBack5){
      newConditionSelection = [previousConditionsSelected objectForKey:@"Neck Pain / stiffness"];
        if(newConditionSelection.boolValue == YES){
          conditionsRow.value = @"Yes";
        }
        else{
          conditionsRow.value = @"No";
        }
    }
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Arthritis in neck" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Arthritis in neck";
    if(wentBack5){
      newConditionSelection = [previousConditionsSelected objectForKey:@"Arthritis in neck"];
        if(newConditionSelection.boolValue == YES){
          conditionsRow.value = @"Yes";
        }
        else{
          conditionsRow.value = @"No";
        }
    }
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Headaches" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Headaches";
    if(wentBack5){
      newConditionSelection = [previousConditionsSelected objectForKey:@"Headaches"];
        if(newConditionSelection.boolValue == YES){
          conditionsRow.value = @"Yes";
        }
        else{
          conditionsRow.value = @"No";
        }
    }
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Jaw Pain / TMJ" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Jaw Pain / TMJ";
    if(wentBack5){
      newConditionSelection = [previousConditionsSelected objectForKey:@"Jaw Pain / TMJ"];
        if(newConditionSelection.boolValue == YES){
          conditionsRow.value = @"Yes";
        }
        else{
          conditionsRow.value = @"No";
        }
    }
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Diabetes" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Diabetes";
    if(wentBack5){
      newConditionSelection = [previousConditionsSelected objectForKey:@"Diabetes"];
        if(newConditionSelection.boolValue == YES){
          conditionsRow.value = @"Yes";
        }
        else{
          conditionsRow.value = @"No";
        }
    }
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Shoulder Pain" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Shoulder Pain";
    if(wentBack5){
      newConditionSelection = [previousConditionsSelected objectForKey:@"Shoulder Pain"];
        if(newConditionSelection.boolValue == YES){
          conditionsRow.value = @"Yes";
        }
        else{
          conditionsRow.value = @"No";
        }
    }
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Pain in elbows / wrists / hand" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Pain in elbows / wrists / hand";
    if(wentBack5){
      newConditionSelection = [previousConditionsSelected objectForKey:@"Pain in elbows / wrists / hand"];
        if(newConditionSelection.boolValue == YES){
          conditionsRow.value = @"Yes";
        }
        else{
          conditionsRow.value = @"No";
        }
    }
    [conditionsSection addFormRow:conditionsRow];

    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Pain in hips / knees / ankles" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Pain in hips / knees / ankles";
    if(wentBack5){
      newConditionSelection = [previousConditionsSelected objectForKey:@"Pain in hips / knees / ankles"];
        if(newConditionSelection.boolValue == YES){
          conditionsRow.value = @"Yes";
        }
        else{
          conditionsRow.value = @"No";
        }
    }
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Arthritis in limbs" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Arthritis in limbs";
    if(wentBack5){
      newConditionSelection = [previousConditionsSelected objectForKey:@"Arthritis in limbs"];
        if(newConditionSelection.boolValue == YES){
          conditionsRow.value = @"Yes";
        }
        else{
          conditionsRow.value = @"No";
        }
    }
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Skin conditions/Rashes" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Skin conditions / Rashes";
    if(wentBack5){
      newConditionSelection = [previousConditionsSelected objectForKey:@"Skin conditions/Rashes"];
        if(newConditionSelection.boolValue == YES){
          conditionsRow.value = @"Yes";
        }
        else{
          conditionsRow.value = @"No";
        }
    }
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Mid back Pain" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Mid back Pain";
    if(wentBack5){
      newConditionSelection = [previousConditionsSelected objectForKey:@"Mid back Pain"];
        if(newConditionSelection.boolValue == YES){
          conditionsRow.value = @"Yes";
        }
        else{
          conditionsRow.value = @"No";
        }
    }
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Muscle cramps / spasms" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Muscle cramps / spasms";
    if(wentBack5){
      newConditionSelection = [previousConditionsSelected objectForKey:@"Muscle cramps / spasms"];
        if(newConditionSelection.boolValue == YES){
          conditionsRow.value = @"Yes";
        }
        else{
          conditionsRow.value = @"No";
        }
    }
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Carpal Tunnel" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Carpal Tunnel";
    if(wentBack5){
      newConditionSelection = [previousConditionsSelected objectForKey:@"Carpal Tunnel"];
        if(newConditionSelection.boolValue == YES){
          conditionsRow.value = @"Yes";
        }
        else{
          conditionsRow.value = @"No";
        }
    }
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Swelling feet / hands" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Swelling feet / hands";
    if(wentBack5){
      newConditionSelection = [previousConditionsSelected objectForKey:@"Swelling feet / hands"];
        if(newConditionSelection.boolValue == YES){
          conditionsRow.value = @"Yes";
        }
        else{
          conditionsRow.value = @"No";
        }
    }
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Anemia/Fatigue" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Anemia / Fatigue";
    if(wentBack5){
      newConditionSelection = [previousConditionsSelected objectForKey:@"Anemia/Fatigue"];
        if(newConditionSelection.boolValue == YES){
          conditionsRow.value = @"Yes";
        }
        else{
          conditionsRow.value = @"No";
        }
    }
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Low Back Pain / stiffness" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Low Back Pain / stiffness";
    if(wentBack5){
      newConditionSelection = [previousConditionsSelected objectForKey:@"Low Back Pain / stiffness"];
        if(newConditionSelection.boolValue == YES){
          conditionsRow.value = @"Yes";
        }
        else{
          conditionsRow.value = @"No";
        }
    }
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Tailbone pain" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Tailbone pain";
    if(wentBack5){
      newConditionSelection = [previousConditionsSelected objectForKey:@"Tailbone pain"];
        if(newConditionSelection.boolValue == YES){
          conditionsRow.value = @"Yes";
        }
        else{
          conditionsRow.value = @"No";
        }
    }
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Numbness/tingling in legs / feet" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Numbness / tingling in legs / feet";
    if(wentBack5){
      newConditionSelection = [previousConditionsSelected objectForKey:@"Numbness/tingling in legs / feet"];
        if(newConditionSelection.boolValue == YES){
          conditionsRow.value = @"Yes";
        }
        else{
          conditionsRow.value = @"No";
        }
    }
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Numbness/tingling in arms / hands" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Numbness / tingling in arms / hands";
    if(wentBack5){
      newConditionSelection = [previousConditionsSelected objectForKey:@"Numbness/tingling in arms / hands"];
        if(newConditionSelection.boolValue == YES){
          conditionsRow.value = @"Yes";
        }
        else{
          conditionsRow.value = @"No";
        }
    }
    [conditionsSection addFormRow:conditionsRow];
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Dizziness" rowType:XLFormRowDescriptorTypeBooleanCheck];
    conditionsRow.title = @"Dizziness";
    if(wentBack5){
      newConditionSelection = [previousConditionsSelected objectForKey:@"Dizziness"];
        if(newConditionSelection.boolValue == YES){
          conditionsRow.value = @"Yes";
        }
        else{
          conditionsRow.value = @"No";
        }
    }
    [conditionsSection addFormRow:conditionsRow];
  
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Allergies" rowType:XLFormRowDescriptorTypeSelectorSegmentedControl title:@"Do you have allergies?"];
    conditionsRow.selectorOptions = @[@"Yes", @"No"];
    conditionsRow.value = @"No";
    if(wentBack6){
      activeOrNo = [previousConditionsSelected objectForKey:@"Allergies"];
      if([activeOrNo isEqual:@"Yes"]){
        activeOrNo = @"Yes";
      }
      else{
        activeOrNo = @"No";
      }
    }
    else{
      activeOrNo = @"No";
    }
    conditionsRow.value = activeOrNo;
    [conditionsSection addFormRow:conditionsRow];
    allergiesChecked = conditionsRow;
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Medications" rowType:XLFormRowDescriptorTypeSelectorSegmentedControl title:@"Are you taking medications?"];
    conditionsRow.selectorOptions = @[@"Yes", @"No"];
    if(wentBack7){
      activeOrNo = [previousConditionsSelected objectForKey:@"Medications"];
      if([activeOrNo isEqual:@"Yes"]){
        activeOrNo = @"Yes";
      }
      else{
        activeOrNo = @"No";
      }
    }
    else{
      activeOrNo = @"No";
    }
    conditionsRow.value = activeOrNo;
    [conditionsSection addFormRow:conditionsRow];
    medicationChecked = conditionsRow;
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Notes" rowType:XLFormRowDescriptorTypeTextView title:@"Notes"];
    [conditionsRow.cellConfigAtConfigure setObject:@"Please add any other relevant information here..." forKey:@"textField.placeholder"];
    if(wentBack5){
      NSString *notesText = [previousConditionsSelected objectForKey:@"Notes"];
      if([notesText isEqual:[NSNull null]]){
        notesText = @"";
      }
      conditionsRow.value = notesText;
    }
    [conditionsSection addFormRow:conditionsRow];

  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"AllergiesText" rowType:XLFormRowDescriptorTypeText];
    [conditionsRow.cellConfigAtConfigure setObject:@"Please list all your allergies here..." forKey:@"textField.placeholder"];
    conditionsRow.required = YES;
    if(wentBack6){
      NSString *allergies = [previousConditionsSelected objectForKey:@"AllergiesText"];
      if([allergies isEqual:[NSNull null]]){
        allergies = @"";
      }
      else{
        conditionsRow.value = allergies;
        allergiesNewCell = conditionsRow;
        [conditionsSection addFormRow:allergiesNewCell afterRow:allergiesChecked];
      }
    }
    else{
      allergiesNewCell = conditionsRow;
    }
  
  
    conditionsRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"MedicationsText" rowType:XLFormRowDescriptorTypeText];
    [conditionsRow.cellConfigAtConfigure setObject:@"Please list any medications you are currently taken..." forKey:@"textField.placeholder"];
    conditionsRow.required = YES;
  
    if(wentBack7){
      NSString *medications = [previousConditionsSelected objectForKey:@"MedicationsText"];
      if([medications isEqual:[NSNull null]]){
        medications = @"";
      }
      else{
        conditionsRow.value = medications;
         medicationNewCell = conditionsRow;
        [conditionsSection addFormRow:medicationNewCell afterRow:medicationChecked];
      }
    }
    else{
      medicationNewCell = conditionsRow;
    }
    self.form = conditionsForm;

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  _questionnarie = [[GeneralTableViewController alloc] init];
  _questionnarie = [segue destinationViewController];
  
  _questionnarie.personalInformation = [NSMutableDictionary dictionaryWithDictionary:_personalInformation];
  _questionnarie.medicalInformation = [NSMutableDictionary dictionaryWithDictionary:_medicalInformation];
  _questionnarie.workInjuryInformation = [NSMutableDictionary dictionaryWithDictionary:_workInjuryInformation];
  _questionnarie.motorVehicleInjuryInformation = [NSMutableDictionary dictionaryWithDictionary:_motorVehicleInjuryInformation];
  _questionnarie.healthCoverageInformation = [NSMutableDictionary dictionaryWithDictionary:_healthCoverageInformation];
  _questionnarie.conditionsInformation = [NSMutableDictionary dictionaryWithDictionary:_conditionsInformation];
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
  
  [self performSegueWithIdentifier:@"gogo" sender:self];
  
  
}

@end
