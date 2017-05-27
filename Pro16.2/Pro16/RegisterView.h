//
//  RegisterView.h
//  Pro16
//
//  Created by idolplay-macpro on 2017/5/9.
//  Copyright © 2017年 namunaka. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegisterViewDelegate <NSObject>


- (void)translateLoginView;

@end

@interface RegisterView : UIView
@property (strong , nonatomic) id <RegisterViewDelegate> delegate;

@end
