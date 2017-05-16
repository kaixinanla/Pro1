//
//  LoginView.m
//  Pro16
//
//  Created by idolplay-macpro on 2017/5/9.
//  Copyright © 2017年 namunaka. All rights reserved.
//

#import "LoginView.h"

@interface LoginView() <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *secretButton;

@property (assign, nonatomic) BOOL hasValidatePhoneNumber;
@property (assign, nonatomic) BOOL hasValidatePassword;

@end

@implementation LoginView


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
  if (self = [super initWithCoder:aDecoder]) {
    
    self.hasValidatePhoneNumber = NO;
    self.hasValidatePassword = NO;
     _phoneNumberTextField.borderStyle = UITextBorderStyleRoundedRect;
      
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
  }
  return self;
}


- (void)textFieldTextDidChange:(id)sender{
  
  UITextField *textField = ((NSNotification *)sender).object;
  if ([textField isEqual:self.phoneNumberTextField]) {
      
    self.hasValidatePhoneNumber = NO;
    
    if (textField.text.length > 11) {
      NSString *str = [ textField.text substringWithRange:NSMakeRange(0, 11)];
      textField.text = str;
      self.hasValidatePhoneNumber = YES;
    }
    
    if (textField.text.length == 11) {
      self.hasValidatePhoneNumber = YES;
    }
      
  }else if ([textField isEqual:self.passwordTextField]){
    
    self.hasValidatePassword = NO;
    
    if (textField.text.length > 16) {
      NSString *str = [ textField.text substringWithRange:NSMakeRange(0, 16)];
      textField.text = str;
      self.hasValidatePassword = YES;
    }
    if (textField.text.length >=6 && textField.text.length <= 16) {
      self.hasValidatePassword = YES;
    }
  }
  
  if (self.hasValidatePhoneNumber && self.hasValidatePassword) {
    self.loginButton.enabled = YES;
  }else{
    self.loginButton.enabled = NO;
  }
  
}

-(IBAction)loginAction:(id)sender {
  if ([self.phoneNumberTextField.text isEqualToString:@"13121598845"] && [self.passwordTextField.text isEqualToString:@"123456"]) {
    NSLog(@"登录成功");
  }else{
    NSLog(@"账号密码错误");
  }
}
-(IBAction)registerAction:(id)sender{
     [self.delegate translateRegisterView];
 

}
- (IBAction)resetPasswordAction:(id)sender{
    [self.delegate translateResetPassword];
 
}

-(IBAction)secretAction:(id)sender{
  self.passwordTextField.secureTextEntry = !self.passwordTextField.secureTextEntry;
  self.secretButton.selected = !self.secretButton.selected;
  
}
-(IBAction)oauthAction:(id)sender{
  
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_passwordTextField resignFirstResponder];
    [_phoneNumberTextField resignFirstResponder];
}

@end
