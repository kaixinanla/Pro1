//
//  ResetPassword.h
//  Pro16
//
//  Created by 于逢源 on 17/5/11.
//  Copyright © 2017年 namunaka. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ResetPasswordDelegate <NSObject>
- (void)translateLoginView1;

@end
@interface ResetPassword : UIView
@property (strong , nonatomic) id <ResetPasswordDelegate> delegate;

@end
