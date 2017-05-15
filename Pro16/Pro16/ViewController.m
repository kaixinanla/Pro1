//
//  ViewController.m
//  Pro16
//
//  Created by idolplay-macpro on 2017/5/9.
//  Copyright © 2017年 namunaka. All rights reserved.
//

#import "ViewController.h"
#import "LoginView.h"
#import "RegisterView.h"
#import "ResetPassword.h"

@interface ViewController () <LoginViewDelegate,RegisterViewDelegate,ResetPasswordDelegate>

@property (strong, nonatomic) LoginView *loginView;
@property (strong, nonatomic) RegisterView *registerView;
@property (strong , nonatomic) ResetPassword *resetPasswordView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.loginView =  [[[NSBundle mainBundle] loadNibNamed:@"LoginView" owner:self options:nil] lastObject];
  self.loginView.delegate = self;
  
  self.registerView = [[[NSBundle mainBundle] loadNibNamed:@"RegisterView" owner:self options:nil] lastObject];
  self.registerView.delegate = self;
  self.resetPasswordView = [[[NSBundle mainBundle] loadNibNamed:@"ResetPassword" owner:self options:nil]lastObject];
    self.resetPasswordView.delegate = self;
    [self.view addSubview:self.resetPasswordView];
    [self.view addSubview:self.registerView];
    [self.view addSubview:self.loginView];
  
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)translateRegisterView {

    __weak ViewController *weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.loginView.alpha = 0.0f;
        weakSelf.registerView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [weakSelf.view bringSubviewToFront:self.registerView];
    }];
}

- (void)translateLoginView{
    [self.view bringSubviewToFront:self.loginView];
    __weak ViewController *weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        
        weakSelf.loginView.alpha = 1.0f;
        weakSelf.registerView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        
        [weakSelf.view bringSubviewToFront:self.loginView];
    }];
}
- (void)translateResetPassword{
    [self.view bringSubviewToFront:self.resetPasswordView ];
}
- (void)translateLoginView1{
    [self.view bringSubviewToFront:self.loginView];
}
@end
