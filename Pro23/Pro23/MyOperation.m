//
//  MyOperation.m
//  Pro23
//
//  Created by 盛嘉 on 2017/5/24.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "MyOperation.h"

@implementation MyOperation
- (void)main
{
  for (int i = 0; i < 2; ++i) {
    NSLog(@"1-----%@",[NSThread currentThread]);
  }
}
@end
