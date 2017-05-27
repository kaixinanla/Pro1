//
//  SJView.h
//  RAC
//
//  Created by 盛嘉 on 2017/5/27.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"
//@class SJView;
//@protocol SJViewDelegate <NSObject>
//
//@optional
//- (void)viewWithTap:(SJView *)view;
//@end
@interface SJView : UIView
//@property (weak , nonatomic) id <SJViewDelegate>delegate;

@property (strong , nonatomic)RACSubject *subject;

@end
