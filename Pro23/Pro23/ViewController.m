//
//  ViewController.m
//  Pro23
//
//  Created by 盛嘉 on 2017/5/23.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "ViewController.h"
#import "MyOperation.h"
#import <AFNetworking.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
//  //1创建NSInvocationOperation
//  NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
//  [op1 start];
//  NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
//    NSLog(@"--------%@",[NSThread currentThread]);
//  }];
//  [op2 start];
 // [self addOperationToQueue];
  //[self opetationQueue];
  //[self addDependency];
//  [self blockOperation];
//  MyOperation *op3 = [[MyOperation alloc]init];
//  [op3 start];
//  NSOperationQueue *queue = [NSOperationQueue mainQueue];
//
  
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  NSDictionary *parameters = @{@"offset":@"0",@"limit":@"5",@"type":@"1"};
 
  [manager POST:@"http://hzt.idoool.com/welfareactivitylist" parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    
  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
   NSLog(@"请求成功 : %@",responseObject);
    
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"Error: %@",error);
  }];


  
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


//- (void)run{
//  NSLog(@"---------%@",[NSThread currentThread]);
//}
- (void)blockOperation
{
  NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
    // 在主线程
    NSLog(@"1------%@", [NSThread currentThread]);
  }];
  
  // 添加额外的任务(在子线程执行)
  [op addExecutionBlock:^{
    NSLog(@"2------%@", [NSThread currentThread]);
  }];
  [op addExecutionBlock:^{
    NSLog(@"3------%@", [NSThread currentThread]);
  }];
  [op addExecutionBlock:^{
    NSLog(@"4------%@", [NSThread currentThread]);
  }];
  
  [op start];
}
- (void)addOperationToQueue
{
  // 1.创建队列
  NSOperationQueue *queue = [[NSOperationQueue alloc] init];
  
  // 2. 创建操作
  // 创建NSInvocationOperation
  NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
  // 创建NSBlockOperation
  NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
    for (int i = 0; i < 2; ++i) {
      NSLog(@"1-----%@", [NSThread currentThread]);
    }
  }];
  
  // 3. 添加操作到队列中：addOperation:
  [queue addOperation:op1]; // [op1 start]
  [queue addOperation:op2]; // [op2 start]
}

- (void)run
{
  for (int i = 0; i < 2; ++i) {
    NSLog(@"2-----%@", [NSThread currentThread]);
  }
}
- (void)addOperationWithBlockToQueue
{
  // 1. 创建队列
  NSOperationQueue *queue = [[NSOperationQueue alloc] init];
  
  // 2. 添加操作到队列中：addOperationWithBlock:
  [queue addOperationWithBlock:^{
    for (int i = 0; i < 2; ++i) {
      NSLog(@"-----%@", [NSThread currentThread]);
    }
  }];
}
- (void)opetationQueue
{
  // 创建队列
  NSOperationQueue *queue = [[NSOperationQueue alloc] init];
  
  // 设置最大并发操作数
  //    queue.maxConcurrentOperationCount = 2;
  queue.maxConcurrentOperationCount = 1; // 就变成了串行队列
  
  // 添加操作
  [queue addOperationWithBlock:^{
    NSLog(@"1-----%@", [NSThread currentThread]);
    [NSThread sleepForTimeInterval:0.01];
  }];
  [queue addOperationWithBlock:^{
    NSLog(@"2-----%@", [NSThread currentThread]);
    [NSThread sleepForTimeInterval:0.01];
  }];
  [queue addOperationWithBlock:^{
    NSLog(@"3-----%@", [NSThread currentThread]);
    [NSThread sleepForTimeInterval:0.01];
  }];
  [queue addOperationWithBlock:^{
    NSLog(@"4-----%@", [NSThread currentThread]);
    [NSThread sleepForTimeInterval:0.01];
  }];
  [queue addOperationWithBlock:^{
    NSLog(@"5-----%@", [NSThread currentThread]);
    [NSThread sleepForTimeInterval:0.01];
  }];
  
  [queue addOperationWithBlock:^{
    NSLog(@"6-----%@", [NSThread currentThread]);
    [NSThread sleepForTimeInterval:0.01];
  }];
}
- (void)addDependency
{
  NSOperationQueue *queue = [[NSOperationQueue alloc] init];
  
  NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
    NSLog(@"1-----%@", [NSThread  currentThread]);
  }];
  NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
    NSLog(@"2-----%@", [NSThread  currentThread]);
  }];
  
  [op2 addDependency:op1];    // 让op2 依赖于 op1，则先执行op1，在执行op2
  
  [queue addOperation:op1];
  [queue addOperation:op2];
}
@end
