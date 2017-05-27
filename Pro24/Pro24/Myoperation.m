//
//  Myoperation.m
//  Pro24
//
//  Created by 盛嘉 on 2017/5/23.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "Myoperation.h"
#import <stdio.h>
#import <stdlib.h>
#import <unistd.h>

NSMutableArray *list;
@interface Myoperation()
{
  int number;
  NSTimeInterval interval; //时间间隔
}
- (id)initWithNum:(int)sn;
- (void)main;
@end

@implementation Myoperation
- (id)initWithNum:(int)sn{
  if ((self = [super init]) != nil) {
    number = sn;
    interval = (double)(random() &0x7f)/256.0;
  }
  return self;
}
- (void)dealloc{
  NSLog(@"Release: %d",number);
}
- (void) main{
  @try{
    @autoreleasepool {
      NSNumber *obj = [NSNumber numberWithInt:number];
      [NSThread sleepForTimeInterval:interval];//等待一会
      @synchronized (list) {
        [list addObject:obj];
      }
    }
  }
  @catch(...){/*只捕捉异常，不做任何操作*/}
}

@end
int main(void){
  const int Tasks = 10;
  srandom((unsigned)getpid());//随机数种子
  @autoreleasepool {
    int i;
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    list = [[NSMutableArray alloc]init];
    for (i = 0; i < Tasks; i++) {//创建操作并将其添加到队列中
      NSOperation *opr = [[Myoperation alloc]initWithNum:i];
      [queue addOperation:opr];
    }
    [NSThread sleepForTimeInterval:2.0];//等待终止
    for (id obj in list)
      printf(" %d", [obj intValue]);
    printf("\n");
  }
  return 0;
}
