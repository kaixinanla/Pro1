//
//  ViewController.m
//  RACCommand
//
//  Created by 盛嘉 on 2017/5/31.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveCocoa.h"



//RACCommand:处理事件
/*
 注意：
 1.RACCommand内部必须要返回signal
 2.executionSignals信号中的信号，一开始获取不到内部信号
 */
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
 RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * (id  input) {
 
   //Command的block
   NSLog(@"执行block,%@",input);
   return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
     //信号block
     NSLog(@"执行信号bolck");
     //发送数据
     [subscriber sendNext:@"你好"];
     //发送完成
     [subscriber sendCompleted];
     return nil;
   }];
 }];
  
  //订阅信号
  //executionSignals信号中的信号
  //监听命令的执行情况有没有完成
  //switchToLatest：获取最近发送的信号
  [command.executionSignals.switchToLatest subscribeNext:^(id x) {
    NSLog(@"%@",x);
  [[command.executing skip:1]subscribeNext:^(id x) {
    BOOL isExecuting = [x boolValue];
    if (isExecuting) {
      NSLog(@"正在执行");
    }else{
      NSLog(@"执行完成");
    }
  }];
    
  }];
  [command.executionSignals.switchToLatest subscribeNext:^(id x) {
  
  }];
//      [command.executing subscribeNext:^(id x) {
//        BOOL isExecuting = [x boolValue];
//        if (isExecuting) {
//          NSLog(@"正在执行");
//        }else{
//          NSLog(@"执行完成");
//        }
//      }];
//  [command.executionSignals subscribeNext:^(id x) {
//    NSLog(@"%@",x);
//    [x subscribeNext:^(id x) {
//      NSLog(@"%@",x);
//    }];
//  }];
  //只要执行execute就会执行
 RACReplaySubject *subject = [command execute:@1];
  [subject sendNext:@1];
  [subject subscribeNext:^(id x) {
    
  }];
  //订阅command内部信号
//  [[command execute:@1]subscribeNext:^(id x) {
//    NSLog(@"%@",x);
//  }];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
