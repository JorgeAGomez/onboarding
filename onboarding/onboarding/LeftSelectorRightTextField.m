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

@interface LeftSelectorRightTextField () <UITextFieldDelegate, UIAlertViewDelegate, UIActionSheetDelegate>

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

-(BOOL)formDescriptorCellCanBecomeFirstResponder
{
    return !self.rowDescriptor.isDisabled;
}

-(BOOL)formDescriptorCellBecomeFirstResponder
{
    return [self.phoneNumberTextField becomeFirstResponder];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return [self.formViewController textFieldShouldClear:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [self.formViewController textFieldShouldReturn:textField];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return [self.formViewController textFieldShouldBeginEditing:textField];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return [self.formViewController textFieldShouldEndEditing:textField];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self.formViewController textField:textField shouldChangeCharactersInRange:range replacementString:string];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.formViewController textFieldDidBeginEditing:textField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self textFieldDidChange:textField];
    [self.formViewController textFieldDidEndEditing:textField];
}

-(void)setReturnKeyType:(UIReturnKeyType)returnKeyType
{
    self.phoneNumberTextField.returnKeyType = returnKeyType;
}

-(UIReturnKeyType)returnKeyType
{
    return self.phoneNumberTextField.returnKeyType;
}

+(CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {
    return 45;
}

#pragma mark - Helpers

- (void)textFieldDidChange:(UITextField *)textField
{
    if (self.phoneNumberTextField == textField) {
        if ([self.phoneNumberTextField.text length] > 0) {
            self.rowDescriptor.value = self.phoneNumberTextField.text;
        } else {
            self.rowDescriptor.value = nil;
        }
    }
}

- (IBAction)phoneTypeTapped:(id)sender {
  
  //create an Action sheet and select the type of phone number
  
  //
  NSLog(@"Button Tapped!!");

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
