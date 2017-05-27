//
//  SJView.m
//  RAC
//
//  Created by 盛嘉 on 2017/5/27.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "SJView.h"

@implementation SJView
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//  if ([_delegate respondsToSelector:@selector(viewWithTap:)]) {
//    [_delegate viewWithTap:self];
//  }
  [_subject sendNext:self];
  //[_subject sendCompleted];
}



@end
