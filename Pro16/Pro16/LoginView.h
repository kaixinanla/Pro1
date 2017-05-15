//
//  LoginView.h
//  Pro16
//
//  Created by idolplay-macpro on 2017/5/9.
//  Copyright © 2017年 namunaka. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LoginViewDelegate <NSObject>

-(void)translateRegisterView;
- (void)translateResetPassword;
@end


@interface LoginView : UIView

@property (strong, nonatomic) id <LoginViewDelegate> delegate;

@end
