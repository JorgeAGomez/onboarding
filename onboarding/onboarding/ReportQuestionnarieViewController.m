//
//  ReportQuestionnarieViewController.m
//  onboarding
//
//  Created by Jorge Gomez on 2016-06-30.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

#import "ReportQuestionnarieViewController.h"
#import "XLForm.h"
#import "FirebaseHelper.h"

NSString *const kMultipleSelector = @"multipleSelector";

@interface ReportQuestionnarieViewController ()

@end

@implementation ReportQuestionnarieViewController

//personal information
NSString *firstName;
NSString *lastName;
NSString *address;
NSString *city;
NSString *province;
NSString *postalCode;
NSString *homePhone;
NSString *cellPhone;
NSString *workPhone;
NSDate *DOB;
NSString *DOBstring;
NSString *PHNnumber;

//medical information
NSString *emergencyContact;
NSString *contactPhoneNumber;
NSString *medicalDoctorName;
NSString *doctorPhoneNumber;
NSString *doctorAddress;

//work Injury
NSString *areYouHereDueToWorkRelatedInjury;
NSDate   *dateOfInjury;
NSString *dateOfInjuryString;
NSString *WCBClaimNumber;
NSString *employer;
NSString *employerPhone;
NSString *employerAddress;
NSString *contactingEmployer;

//motorVehicle Injury
NSString *motorVehicleInjury;
NSString *insurance;
NSDate *dateOfAccident;
NSString *dateOfAccidentString;
NSString *claimPolicy;
NSString *adjuster;
NSString *phoneNumber;
NSString *fax;
NSString *nameOnPolicy;
NSString *legalRepresentative;

//extended health coverage
NSString *extendedHealthCoverage;
NSString *insuranceName;

//reportQuestionnarie
NSArray *conditions;
NSString *allergies;
NSString *medications;
NSString *notes;


//MARK: Instance Variables
XLFormDescriptor *conditionSelectorForm;
XLFormSectionDescriptor *conditionSelectorSection;
XLFormRowDescriptor *conditionSelectorRow;

//General
XLFormSectionDescriptor *generalSelectorSection;
XLFormRowDescriptor *generalPastSelectorRow;
XLFormRowDescriptor *generalCurrentSelectorRow;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

    
    conditionSelectorForm.assignFirstResponderOnShow = YES;
    
    conditionSelectorForm = [XLFormDescriptor formDescriptorWithTitle:@"Health Report Questionnaire"];
    conditionSelectorSection = [XLFormSectionDescriptor formSection];
    //conditionSelectorSection.title = @"Check off any of the following conditions that you may be experiencing";
    //conditionSelectorSection.title = @"Check all that apply";
    [conditionSelectorForm addFormSection:conditionSelectorSection];
    
    //MARK: Conditions
    conditionSelectorSection = [XLFormSectionDescriptor formSectionWithTitle:@"Conditions"];
    [conditionSelectorForm addFormSection:conditionSelectorSection];
    
    //conditionSelectorRow.selectorTitle = @"Select all prior or current conditions";
    conditionSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"currentPriorConditions" rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all prior or current conditions"];
    conditionSelectorRow.selectorOptions = @[@"Neck Pain / Stiffness", @"Arthritis in neck", @"Headaches", @"Jaw Pain / TMJ ", @"Diabetes",
                                             @"Shoulder Pain", @"Pain in elbows / wrists / hand", @"Pain in hips / knees / ankles", @"Arthritis in limbs", @"Skin conditions/Rashes",
                                             @"Mid back Pain", @"Muscle cramps / spasms", @"Carpal Tunnel", @"Swelling feet / hands", @"Anemia/Fatigue",
                                             @"Low Back Pain / stiffness", @"Tailbone pain", @"Numbness/tingling in legs / feet", @"Numbness/tingling in arms / hands", @"Dizziness"];
    //conditionSelectorRow.value = @[];
    [conditionSelectorSection addFormRow:conditionSelectorRow];
    
    XLFormRowDescriptor *allergyInfoRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Allergies" rowType:XLFormRowDescriptorTypeText title:@"Allergies"];
    [conditionSelectorSection addFormRow:allergyInfoRow];
    
    XLFormRowDescriptor *medicationInfoRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Medication" rowType:XLFormRowDescriptorTypeText title:@"Medication"];
    [conditionSelectorSection addFormRow:medicationInfoRow];
    
    XLFormRowDescriptor *notesInfoRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"Notes" rowType:XLFormRowDescriptorTypeText title:@"Notes"];
    [conditionSelectorSection addFormRow:notesInfoRow];
    
    //MARK: Health Report Questionnaire
    

    //General
    
    //TEMP:
    //generalPastSelectorRow.tag = @"test";
    
    generalSelectorSection = [XLFormSectionDescriptor formSectionWithTitle:@"General"];
    [conditionSelectorForm addFormSection:generalSelectorSection];
    generalPastSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"pastGeneral" rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all past conditions"];
    generalPastSelectorRow.selectorOptions = @[@"Diabetes", @"Hypoglycemia", @"Stress/Depression", @"Epilepsy/Seizures",
                                               @"Skin conditions/Rashes", @"Alcoholism", @"High Cholesterol ", @"Parkinson’s disease",
                                               @"Heart disease", @"Cancer", @"Osteoarthritis", @"Ulcers",
                                               @"Anemia/Fatigue", @"Multiple Sclerosis", @"Thyroid", @"Osteoporosis"];
    [generalSelectorSection addFormRow:generalPastSelectorRow];
    
    generalCurrentSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"currentGeneral" rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all current conditions"];
    generalCurrentSelectorRow.selectorOptions = @[@"Diabetes", @"Hypoglycemia", @"Stress/Depression", @"Epilepsy/Seizures",
                                                  @"Skin conditions/Rashes", @"Alcoholism", @"High Cholesterol ", @"Parkinson’s disease",
                                                  @"Heart disease", @"Cancer", @"Osteoarthritis", @"Ulcers",
                                                  @"Anemia/Fatigue", @"Multiple Sclerosis", @"Thyroid", @"Osteoporosis"];
    [generalSelectorSection addFormRow:generalCurrentSelectorRow];
    
    //Immune System
    XLFormSectionDescriptor *immuneSystemSelectorSection;
    XLFormRowDescriptor *immuneSystemPastSelectorRow;
    XLFormRowDescriptor *immuneSystemCurrentSelectorRow;
    
    immuneSystemSelectorSection = [XLFormSectionDescriptor formSectionWithTitle:@"Immune System/Infection"];
    [conditionSelectorForm addFormSection:immuneSystemSelectorSection];
    immuneSystemPastSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all past conditions"];
    
    immuneSystemPastSelectorRow.selectorOptions = @[@"HIV (AIDS)", @"Pneumonia", @"Allergies/sinus troubles", @"Catch colds/flue Easily",
                                                    @"Rheumatoid Arthritis ", @"Venereal Disease", @"Tuberculosis", @"Rheumatic Fever"];
    [immuneSystemSelectorSection addFormRow:immuneSystemPastSelectorRow];
    
    immuneSystemCurrentSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all current conditions"];
    immuneSystemCurrentSelectorRow.selectorOptions = @[@"HIV (AIDS)", @"Pneumonia", @"Allergies/sinus troubles", @"Catch colds/flue Easily",
                                                       @"Rheumatoid Arthritis ", @"Venereal Disease", @"Tuberculosis", @"Rheumatic Fever"];
    [immuneSystemSelectorSection addFormRow:immuneSystemCurrentSelectorRow];
    
    //Gastrointestinal
    XLFormSectionDescriptor *gastroSelectorSection;
    XLFormRowDescriptor *gastroPastSelectorRow;
    XLFormRowDescriptor *gastroCurrentSelectorRow;
    
    gastroSelectorSection = [XLFormSectionDescriptor formSectionWithTitle:@"GastroIntestinal"];
    [conditionSelectorForm addFormSection:gastroSelectorSection];
    gastroPastSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all past conditions"];
    
    gastroPastSelectorRow.selectorOptions = @[@"Gall Bladder Problem", @"Colitis", @"Blood in Stool", @"Constipation", @"Burning in Stomach",
                                              @"Heartburn", @"Excessive Thirst", @"Vomiting", @"Recent Weight Gain", @"Liver Trouble/Hepatitis",
                                              @"Mucus in Stool", @"Diarrhea", @"Pain over Stomach", @"Burping/Bloating", @"Distress from Greasy Food",
                                              @"Nausea", @"Hiatal Hernia", @"Metallic Taste", @"Recent Weight Loss"];
    [gastroSelectorSection addFormRow:gastroPastSelectorRow];
    
    gastroCurrentSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all current conditions"];
    gastroCurrentSelectorRow.selectorOptions = @[@"Gall Bladder Problem", @"Colitis", @"Blood in Stool", @"Constipation", @"Burning in Stomach",
                                                 @"Heartburn", @"Excessive Thirst", @"Vomiting", @"Recent Weight Gain", @"Liver Trouble/Hepatitis",
                                                 @"Mucus in Stool", @"Diarrhea", @"Pain over Stomach", @"Burping/Bloating", @"Distress from Greasy Food",
                                                 @"Nausea", @"Hiatal Hernia", @"Metallic Taste", @"Recent Weight Loss"];
    [gastroSelectorSection addFormRow:gastroCurrentSelectorRow];
    
    //Cardiovascular
    XLFormSectionDescriptor *cardioSelectorSection;
    XLFormRowDescriptor *cardioPastSelectorRow;
    XLFormRowDescriptor *cardioCurrentSelectorRow;
    
    cardioSelectorSection = [XLFormSectionDescriptor formSectionWithTitle:@"Cardiovascular"];
    [conditionSelectorForm addFormSection:cardioSelectorSection];
    cardioPastSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all past conditions"];
    
    cardioPastSelectorRow.selectorOptions = @[@"Irregular Heartbeat", @"Stroke/Heart Attack", @"Low Blood Pressure", @"High Blood Pressure",
                                              @"Palpitations", @"Swelling Ankles", @"Pain/Pressure in Chest", @"Shortness of Breath"];
    [cardioSelectorSection addFormRow:cardioPastSelectorRow];
    
    cardioCurrentSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all current conditions"];
    cardioCurrentSelectorRow.selectorOptions = @[@"Irregular Heartbeat", @"Stroke/Heart Attack", @"Low Blood Pressure", @"High Blood Pressure",
                                                 @"Palpitations", @"Swelling Ankles", @"Pain/Pressure in Chest", @"Shortness of Breath"];
    [cardioSelectorSection addFormRow:cardioCurrentSelectorRow];
    
    //Nervous System
    XLFormSectionDescriptor *nervousSelectorSection;
    XLFormRowDescriptor *nervousPastSelectorRow;
    XLFormRowDescriptor *nervousCurrentSelectorRow;
    
    nervousSelectorSection = [XLFormSectionDescriptor formSectionWithTitle:@"Nervous System"];
    [conditionSelectorForm addFormSection:nervousSelectorSection];
    nervousPastSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all past conditions"];
    
    nervousPastSelectorRow.selectorOptions = @[@"Dizziness/Lightheaded", @"Fainting", @"Discoordination", @"Memory Loss"];
    [nervousSelectorSection addFormRow:nervousPastSelectorRow];
    
    nervousCurrentSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all current conditions"];
    nervousCurrentSelectorRow.selectorOptions = @[@"Dizziness/Lightheaded", @"Fainting", @"Discoordination", @"Memory Loss"];
    [nervousSelectorSection addFormRow:nervousCurrentSelectorRow];
    
    //Respiratory
    XLFormSectionDescriptor *respiratorySelectorSection;
    XLFormRowDescriptor *respiratoryPastSelectorRow;
    XLFormRowDescriptor *respiratoryCurrentSelectorRow;
    
    respiratorySelectorSection = [XLFormSectionDescriptor formSectionWithTitle:@"Respiratory"];
    [conditionSelectorForm addFormSection:respiratorySelectorSection];
    respiratoryPastSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all past conditions"];
    
    respiratoryPastSelectorRow.selectorOptions = @[@"Chronic Cough ", @"Spitting Blood", @"Difficulty Breathing", @"Shortness of Breath ",
                                                   @"Asthma", @"Spitting up Phlegm", @"Emphysema"];
    [respiratorySelectorSection addFormRow:respiratoryPastSelectorRow];
    
    respiratoryCurrentSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all current conditions"];
    respiratoryCurrentSelectorRow.selectorOptions = @[@"Chronic Cough ", @"Spitting Blood", @"Difficulty Breathing", @"Shortness of Breath ",
                                                      @"Asthma", @"Spitting up Phlegm", @"Emphysema"];
    [respiratorySelectorSection addFormRow:respiratoryCurrentSelectorRow];
    
    //Blood Sugar
    XLFormSectionDescriptor *bloodSugarSelectorSection;
    XLFormRowDescriptor *bloodSugarPastSelectorRow;
    XLFormRowDescriptor *bloodSugarCurrentSelectorRow;
    
    bloodSugarSelectorSection = [XLFormSectionDescriptor formSectionWithTitle:@"Blood Sugar"];
    [conditionSelectorForm addFormSection:bloodSugarSelectorSection];
    bloodSugarPastSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all past conditions"];
    
    bloodSugarPastSelectorRow.selectorOptions = @[@"Irritable before Meals", @"Palpitations if miss meals", @"Gets shaky if Hungry", @" Awaken from sleep"];
    [bloodSugarSelectorSection addFormRow:bloodSugarPastSelectorRow];
    
    bloodSugarCurrentSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all current conditions"];
    bloodSugarCurrentSelectorRow.selectorOptions = @[@"Irritable before Meals", @"Palpitations if miss meals", @"Gets shaky if Hungry", @" Awaken from sleep"];
    [bloodSugarSelectorSection addFormRow:bloodSugarCurrentSelectorRow];
    
    //Eye, Ear, Nose and Throat
    XLFormSectionDescriptor *eyeEarNoseThroatSelectorSection;
    XLFormRowDescriptor *eyeEarNoseThroatPastSelectorRow;
    XLFormRowDescriptor *eyeEarNoseThroatCurrentSelectorRow;
    
    eyeEarNoseThroatSelectorSection = [XLFormSectionDescriptor formSectionWithTitle:@"Eye, Ear, Nose and Throat"];
    [conditionSelectorForm addFormSection:eyeEarNoseThroatSelectorSection];
    eyeEarNoseThroatPastSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all past conditions"];
    
    eyeEarNoseThroatPastSelectorRow.selectorOptions =   @[@"Vision Problems ", @"Hoarseness", @"Nose Bleeding", @"Ear Pain",
                                                          @"Dental Problems", @"Hearing Loss", @"Sore Throat", @"Ringing in Ear(s)"];
    [eyeEarNoseThroatSelectorSection addFormRow:eyeEarNoseThroatPastSelectorRow];
    
    eyeEarNoseThroatCurrentSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all current conditions"];
    eyeEarNoseThroatCurrentSelectorRow.selectorOptions = @[@"Vision Problems ", @"Hoarseness", @"Nose Bleeding", @"Ear Pain",
                                                           @"Dental Problems", @"Hearing Loss", @"Sore Throat", @"Ringing in Ear(s)"];
    [eyeEarNoseThroatSelectorSection addFormRow:eyeEarNoseThroatCurrentSelectorRow];
    
    //Urinary Tract
    XLFormSectionDescriptor *urinarySelectorSection;
    XLFormRowDescriptor *urinaryPastSelectorRow;
    XLFormRowDescriptor *urinaryCurrentSelectorRow;
    
    urinarySelectorSection = [XLFormSectionDescriptor formSectionWithTitle:@"Urinary Tract"];
    [conditionSelectorForm addFormSection:urinarySelectorSection];
    urinaryPastSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all past conditions"];
    
    urinaryPastSelectorRow.selectorOptions = @[@"Blood in Urine", @"Bladder Infection", @"Inability to Control Urination", @"Kidney Stones",
                                               @"Painful Urination"];
    [urinarySelectorSection addFormRow:urinaryPastSelectorRow];
    
    urinaryCurrentSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all current conditions"];
    urinaryCurrentSelectorRow.selectorOptions = @[@"Blood in Urine", @"Bladder Infection", @"Inability to Control Urination", @"Kidney Stones",
                                                  @"Painful Urination"];
    [urinarySelectorSection addFormRow:urinaryCurrentSelectorRow];
    
    //MARK: Neuromusculoskeletal
    
    //Head & Neck
    XLFormSectionDescriptor *headNeckSelectorSection;
    XLFormRowDescriptor *headNeckPastSelectorRow;
    XLFormRowDescriptor *headNeckCurrentSelectorRow;
    
    headNeckSelectorSection = [XLFormSectionDescriptor formSectionWithTitle:@"Head & Neck"];
    [conditionSelectorForm addFormSection:headNeckSelectorSection];
    headNeckPastSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all past conditions"];
    
    headNeckPastSelectorRow.selectorOptions = @[@"Headaches", @"Neck Pain/stiffness", @"Pinched nerve", @"Jaw Pain/TMJ",
                                                @"Arthritis in neck"];
    [headNeckSelectorSection addFormRow:headNeckPastSelectorRow];
    
    headNeckCurrentSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all current conditions"];
    headNeckCurrentSelectorRow.selectorOptions = @[@"Headaches", @"Neck Pain/stiffness", @"Pinched nerve", @"Jaw Pain/TMJ",
                                                   @"Arthritis in neck"];
    [headNeckSelectorSection addFormRow:headNeckCurrentSelectorRow];
    
    //Shoulder
    XLFormSectionDescriptor *shoulderSelectorSection;
    XLFormRowDescriptor *shoulderPastSelectorRow;
    XLFormRowDescriptor *shoulderCurrentSelectorRow;
    
    shoulderSelectorSection = [XLFormSectionDescriptor formSectionWithTitle:@"Shoulder"];
    [conditionSelectorForm addFormSection:shoulderSelectorSection];
    shoulderPastSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all past conditions"];
    
    shoulderPastSelectorRow.selectorOptions = @[@"Shoulder Pain", @"Can’t raise arm", @"Arthritis", @"Bursitis",
                                                @"Clicking/popping"];
    [shoulderSelectorSection addFormRow:shoulderPastSelectorRow];
    
    shoulderCurrentSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all current conditions"];
    shoulderCurrentSelectorRow.selectorOptions = @[@"Shoulder Pain", @"Can’t raise arm", @"Arthritis", @"Bursitis",
                                                   @"Clicking/popping"];
    [shoulderSelectorSection addFormRow:shoulderCurrentSelectorRow];
    
    //Mid-back
    XLFormSectionDescriptor *midBackSelectorSection;
    XLFormRowDescriptor *midBackPastSelectorRow;
    XLFormRowDescriptor *midBackCurrentSelectorRow;
    
    midBackSelectorSection = [XLFormSectionDescriptor formSectionWithTitle:@"Mid Back"];
    [conditionSelectorForm addFormSection:midBackSelectorSection];
    midBackPastSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all past conditions"];
    
    midBackPastSelectorRow.selectorOptions = @[@"Mid back Pain", @"Pain between shoulders", @"Muscle Spasms", @"Sharp stabbing pain"];
    [midBackSelectorSection addFormRow:midBackPastSelectorRow];
    
    midBackCurrentSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all current conditions"];
    midBackCurrentSelectorRow.selectorOptions = @[@"Mid back Pain", @"Pain between shoulders", @"Muscle Spasms", @"Sharp stabbing pain"];
    [midBackSelectorSection addFormRow:midBackCurrentSelectorRow];
    
    //Low back
    XLFormSectionDescriptor *lowBackSelectorSection;
    XLFormRowDescriptor *lowBackPastSelectorRow;
    XLFormRowDescriptor *lowBackCurrentSelectorRow;
    
    lowBackSelectorSection = [XLFormSectionDescriptor formSectionWithTitle:@"Low Back"];
    [conditionSelectorForm addFormSection:lowBackSelectorSection];
    lowBackPastSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all past conditions"];
    
    lowBackPastSelectorRow.selectorOptions = @[@"Low Back Pain", @"Low Back stiffness", @"Tailbone pain", @"Muscle spasms",
                                               @" Pinched nerve"];
    [lowBackSelectorSection addFormRow:lowBackPastSelectorRow];
    
    lowBackCurrentSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all current conditions"];
    lowBackCurrentSelectorRow.selectorOptions = @[@"Low Back Pain", @"Low Back stiffness", @"Tailbone pain", @"Muscle spasms",
                                                  @" Pinched nerve"];
    [lowBackSelectorSection addFormRow:lowBackCurrentSelectorRow];
    
    //Arms & Hands
    XLFormSectionDescriptor *armsHandsSelectorSection;
    XLFormRowDescriptor *armsHandsPastSelectorRow;
    XLFormRowDescriptor *armsHandsCurrentSelectorRow;
    
    armsHandsSelectorSection = [XLFormSectionDescriptor formSectionWithTitle:@"Arms & Hands"];
    [conditionSelectorForm addFormSection:armsHandsSelectorSection];
    armsHandsPastSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all past conditions"];
    
    armsHandsPastSelectorRow.selectorOptions = @[@"Pain in elbow/arm", @"Pain in forearm", @"Pain in hands/fingers", @"Arthritis/swollen hands",
                                                 @"Cold hands", @"Carpal Tunnel", @"Tingling in hands", @"Loss of grip strength"];
    [armsHandsSelectorSection addFormRow:armsHandsPastSelectorRow];
    
    armsHandsCurrentSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all current conditions"];
    armsHandsCurrentSelectorRow.selectorOptions = @[@"Pain in elbow/arm", @"Pain in forearm", @"Pain in hands/fingers", @"Arthritis/swollen hands",
                                                    @"Cold hands", @"Carpal Tunnel", @"Tingling in hands", @"Loss of grip strength"];
    [armsHandsSelectorSection addFormRow:armsHandsCurrentSelectorRow];
    
    //Hips, Legs & Feet
    XLFormSectionDescriptor *hipsLegsFeetSelectorSection;
    XLFormRowDescriptor *hipsLegsFeetPastSelectorRow;
    XLFormRowDescriptor *hipsLegsFeetCurrentSelectorRow;
    
    hipsLegsFeetSelectorSection = [XLFormSectionDescriptor formSectionWithTitle:@"Hips, Legs and Feet"];
    [conditionSelectorForm addFormSection:hipsLegsFeetSelectorSection];
    hipsLegsFeetPastSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all past conditions"];
    
    hipsLegsFeetPastSelectorRow.selectorOptions = @[@"Pain in buttock", @"Pain in hip/knee joint", @"Cold feet", @"Tingling in Feet",
                                                    @"Arthritis", @"Sprain/strain", @"Pain down leg(s)", @"Tingling in leg(s)",
                                                    @"Swollen ankle/feet", @"Pain in ankle/feet", @"Loss of leg strength", @"Muscles cramps"];
    [hipsLegsFeetSelectorSection addFormRow:hipsLegsFeetPastSelectorRow];
    
    hipsLegsFeetCurrentSelectorRow = [XLFormRowDescriptor formRowDescriptorWithTag:kMultipleSelector rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Select all current conditions"];
    hipsLegsFeetCurrentSelectorRow.selectorOptions = @[@"Pain in buttock", @"Pain in hip/knee joint", @"Cold feet", @"Tingling in Feet",
                                                       @"Arthritis", @"Sprain/strain", @"Pain down leg(s)", @"Tingling in leg(s)",
                                                       @"Swollen ankle/feet", @"Pain in ankle/feet", @"Loss of leg strength", @"Muscles cramps"];
    [hipsLegsFeetSelectorSection addFormRow:hipsLegsFeetCurrentSelectorRow];
    
    
    self.form = conditionSelectorForm;
}



- (IBAction)doneButton:(id)sender {

  

    ////**** Saving Personal Information *****////
  
    /*
    firstName = [_personalInformation objectForKey:@"First name"];
    lastName = [_personalInformation objectForKey:@"Last name"];
    address = [_personalInformation objectForKey:@"Address"];
    city = [_personalInformation objectForKey:@"City"];
    province = [_personalInformation objectForKey:@"Province"];
    province = province.displayText;
    postalCode = [_personalInformation objectForKey:@"Postal Code"];
    homePhone = [_personalInformation objectForKey:@"Home Phone #"];
    cellPhone = [_personalInformation objectForKey:@"Cell Phone #"];
    workPhone = [_personalInformation objectForKey:@"Work Phone #"];
    DOB = [_personalInformation objectForKey:@"Date of Birth"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    DOBstring = [dateFormatter stringFromDate:DOB];
    PHNnumber = [_personalInformation objectForKey:@"PHN No."];
  
    //Patient's medical Info
    emergencyContact = [_medicalInformation objectForKey:@"Emergency Contact"];
    contactPhoneNumber = [_medicalInformation objectForKey:@"Contact Phone"];
    medicalDoctorName = [_medicalInformation objectForKey:@"Medical Doctor's Name"];
    doctorPhoneNumber = [_medicalInformation objectForKey:@"Doctor Phone"];
    doctorAddress = [_medicalInformation objectForKey:@"Address"];
  
   // [FirebaseHelper savePatient:firstName :lastName :address :city :province :postalCode :homePhone :cellPhone :workPhone :DOBstring :PHNnumber :emergencyContact :contactPhoneNumber :medicalDoctorName :doctorPhoneNumber :address];
  
  
    //work related injury
    areYouHereDueToWorkRelatedInjury = [_workInjuryInformation objectForKey:@"Work Related Injury"];
    areYouHereDueToWorkRelatedInjury = areYouHereDueToWorkRelatedInjury.displayText;
    dateOfInjury = [_workInjuryInformation objectForKey:@"Date of Injury"];
    dateOfInjuryString = [dateFormatter stringFromDate:dateOfInjury];
    WCBClaimNumber = [_workInjuryInformation objectForKey:@"WCB Claim No."];
    employer = [_workInjuryInformation objectForKey:@"Employer"];
    employerPhone = [_workInjuryInformation objectForKey:@"Employer Phone"];
    employerAddress = [_workInjuryInformation objectForKey:@"Employer Address"];
    contactingEmployer = [_workInjuryInformation objectForKey:@"Contact employer"];
    contactingEmployer = contactingEmployer.displayText;

    //[FirebaseHelper workInjuryData:areYouHereDueToWorkRelatedInjury :dateOfInjuryString :WCBClaimNumber :employer :employerPhone :employerAddress :contactingEmployer];
  
  
    //motor vehicle injury
    motorVehicleInjury = [_motorVehicleInjuryInformation objectForKey:@"Motor Vehicle Injury"];
    motorVehicleInjury = motorVehicleInjury.displayText;
    insurance = [_motorVehicleInjuryInformation objectForKey:@"Insurence"];
    dateOfAccident = [_motorVehicleInjuryInformation objectForKey:@"Date of accident"];
    dateOfAccidentString = [dateFormatter stringFromDate:dateOfAccident];
  
    claimPolicy = [_motorVehicleInjuryInformation objectForKey:@"Claim/Policy #"];
    adjuster = [_motorVehicleInjuryInformation objectForKey:@"Adjuster"];
    phoneNumber = [_motorVehicleInjuryInformation objectForKey:@"Phone No."];
    fax = [_motorVehicleInjuryInformation objectForKey:@"Fax #"];
    nameOnPolicy = [_motorVehicleInjuryInformation objectForKey:@"Name on Policy"];
    legalRepresentative = [_motorVehicleInjuryInformation objectForKey:@"Legal Representative"];
  
    if(legalRepresentative == nil){
      legalRepresentative = @"N/A";
    }
  
   // [FirebaseHelper motorVehicleInjury:motorVehicleInjury :insurance :dateOfAccidentString :claimPolicy :adjuster :phoneNumber :fax :nameOnPolicy :legalRepresentative];

    //extended health coverage
    extendedHealthCoverage = [_healthCoverageInformation objectForKey:@"Extended Health Coverage"];
    extendedHealthCoverage = extendedHealthCoverage.displayText;
    insuranceName = [_healthCoverageInformation objectForKey:@"Insurance Company"];
  
    //[FirebaseHelper extendedHealthCoverage:extendedHealthCoverage :insuranceName];
  
    //ReportQuestionnarie
    _reportQuestionnarieInformation = [self formValues];
    conditions = [_reportQuestionnarieInformation objectForKey:@"currentPriorConditions"];
    allergies = [_reportQuestionnarieInformation objectForKey:@"Allergies"];
    medications = [_reportQuestionnarieInformation objectForKey:@"Medication"];
    notes = [_reportQuestionnarieInformation objectForKey:@"Notes"];
    */
  
  
  
  
  

}
@end
