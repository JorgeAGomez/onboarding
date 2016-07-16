//
//  LeftSelectorRightTextField.m
//  onboarding
//
//  Created by Jorge Gomez on 2016-07-16.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

#import "LeftSelectorRightTextField.h"
#import "NSObject+XLFormAdditions.h"

NSString * const XLFormRowDescriptorTypeLeftSelectRightText = @"XLFormRowDescriptorTypeLeftSelectRightText";

@interface LeftSelectorRightTextField () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *phoneTypeButton;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;


@end

@implementation LeftSelectorRightTextField

+(void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:NSStringFromClass([LeftSelectorRightTextField class]) forKey:XLFormRowDescriptorTypeLeftSelectRightText];
}

- (void)configure
{
    [super configure];
    [self.contentView addSubview:self.phoneNumberTextField];
    [self.phoneNumberTextField setDelegate:self];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
  
    [self configureButtons];
}

-(void)update
{
    [super update];
    self.phoneNumberTextField.text = self.rowDescriptor.value ? [self.rowDescriptor.value displayText] : self.rowDescriptor.noValueDisplayText;
    [self.phoneNumberTextField setEnabled:!self.rowDescriptor.isDisabled];
}


- (IBAction)phoneTypeTapped:(id)sender {
  
  //create an Action sheet and select the type of phone number
  

}

-(void)configureButtons
{
    for (UIView *subview in self.contentView.subviews)
    {
        if ([subview isKindOfClass:[UIButton class]])
        {
            UIButton * button = (UIButton *)subview;
            button.titleLabel.text = @"Home #";
            button.adjustsImageWhenHighlighted = NO;
        }
    }
}

-(void)updateButtons
{
    NSDictionary * value = self.rowDescriptor.value;
  
    self.phoneTypeButton.selected = [[value objectForKey:@"phoneType"] boolValue];
  
    //[self.phoneTypeButton setAlpha:((self.rowDescriptor.isDisabled) ? .6 : 1)];

}




@end
