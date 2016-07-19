//  ReleaseCollectConsentViewController.m
//  onboarding
//
//  Created by Jorge Gomez on 2016-07-05.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

#import "ReleaseCollectConsentViewController.h"
#import <ResearchKit/ResearchKit.h>

@interface ReleaseCollectConsentViewController ()
@property (weak, nonatomic) IBOutlet UITextField *collectInfoInitialsTextField;

@end

@implementation ReleaseCollectConsentViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self test];
}

-(void)test{
  ORKConsentDocument *document = [ORKConsentDocument new];
    ORKConsentSection *section1 =
      [[ORKConsentSection alloc] initWithType:ORKConsentSectionTypeDataGathering];
    section1.title = @"The title of the section goes here ...";
    section1.summary = @"The summary about the section goes here ...";
    section1.content = @"The content to show in learn more ...";

    // Create additional section objects for later sections
    document.sections = @[section1];

    ORKVisualConsentStep *step =
      [[ORKVisualConsentStep alloc] initWithIdentifier:@"visualConsent" document:document];
  
      [step consentDocument];

    // Add the document to a visual consent step and/or a review step:
    ORKVisualConsentStep *visualConsent =
      [[ORKVisualConsentStep alloc] initWithIdentifier:@"visualConsent" document:document];
  
    [visualConsent consentDocument];

}

@end
