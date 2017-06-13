//
//  RegisterView.m
//  Pro16
//
//  Created by idolplay-macpro on 2017/5/9.
//  Copyright © 2017年 namunaka. All rights reserved.
//

#import "RegisterView.h"
@interface RegisterView () <UITextFieldDelegate>
@property (weak , nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak , nonatomic) IBOutlet UITextField *verificationCodeTextField;
@property (weak , nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak , nonatomic) IBOutlet UIButton *registerButton;
@property (weak , nonatomic) IBOutlet UIButton *secretButton;
@property (weak , nonatomic) IBOutlet UIButton *verificationButton;

@property (assign, nonatomic) BOOL hasValidatePhoneNumber;
@property (assign, nonatomic) BOOL hasValidatePassword;
@property (assign , nonatomic) BOOL hasValidateVerificationCode;
@end
@implementation RegisterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.hasValidatePassword = NO;
        self.hasValidatePhoneNumber = NO;
        self.hasValidateVerificationCode = NO;
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    }
    return self;
}
- (void)textFieldTextDidChange:(id)sender{
    UITextField *textField = ((NSNotification *)sender).object;
    if ([textField isEqual:self.phoneNumberTextField]) {
        self.hasValidatePhoneNumber = NO;
        if (textField.text.length > 11) {
            NSString *str = [textField.text substringWithRange:NSMakeRange(0, 11)];
            textField.text = str;
            self.hasValidatePhoneNumber = YES;
        }
            if (textField.text.length == 11) {
            self.hasValidatePhoneNumber = YES;
        }
        
    }else if ([textField isEqual:self.verificationCodeTextField]){
        self.hasValidateVerificationCode = NO;
        if (textField.text.length > 6) {
            NSString *str = [textField.text substringWithRange:NSMakeRange(0, 6)];
            textField.text = str;
            self.hasValidateVerificationCode = YES;
        }if (textField.text.length == 6) {
            self.hasValidateVerificationCode = YES;
        }
    }else if ([textField isEqual:self.passwordTextField]){
        self.hasValidatePassword = NO;
        if (textField.text.length > 16) {
            NSString *str = [textField.text substringWithRange:NSMakeRange(0, 16)];
            textField.text = str;
            self.hasValidatePassword = YES;
            
        }
        if (textField.text.length >=6 && textField.text.length <=16) {
            self.hasValidatePassword = YES;
        }
    }
    if (self.hasValidatePhoneNumber && self.hasValidateVerificationCode && self.hasValidatePassword) {
        self.registerButton.enabled = YES;
    }else{
        self.registerButton.enabled = NO;
    }if (self.hasValidatePhoneNumber) {
        self.verificationButton.enabled = YES;
    }else{
        self.verificationButton.enabled = NO;
    }
      
}
- (IBAction)registerButton:(id)sender{
    if ([self.phoneNumberTextField.text isEqualToString:@"13121598845"] && [self.verificationCodeTextField.text isEqualToString:@"654321"] && [self.passwordTextField.text isEqualToString:@"123456"]) {
        NSLog(@"账号已存在");
    }else{
        NSLog(@"注册成功");
    }
}
- (IBAction)loginViewButton:(id)sender{
   // [self.delegate translateLoginView];
    
}
- (IBAction)secretButton:(id)sender{
    self.passwordTextField.secureTextEntry = !self.passwordTextField.secureTextEntry;
    self.secretButton.selected = !self.secretButton.selected;
}
- (IBAction)oauthButton:(id)sender{
    
}

- (IBAction)verificationButtonAction:(id)sender{
    [self  openCountdown];
}
-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
  __weak typeof (self)weakSelf = self;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [weakSelf.verificationButton setTitle:@"重新发送" forState:UIControlStateNormal];
             
                weakSelf.verificationButton.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [weakSelf.verificationButton setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
          
                weakSelf.verificationButton.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_phoneNumberTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_verificationButton resignFirstResponder];
}
@end
