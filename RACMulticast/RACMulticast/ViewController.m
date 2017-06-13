//
//  ViewController.m
//  RACMulticast
//
//  Created by 盛嘉 on 2017/5/31.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveCocoa.h"
//Multicast:广播链接
//RACMulticastConnection:解决RACSignal副作用
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
      //网络请求：请求一次
  @weakify(self)
  RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    @strongify(self);
    //网络请求
    NSLog(@"发送请求");
    [self loadData:^(id data) {
      
      [subscriber sendNext:data];
    }];
    
    return nil;
  }];
  //RACSignal 转换为RACMulticastConnection
  RACMulticastConnection *connection = [signal publish];
  
  [connection.signal subscribeNext:^(id x) {
    
  }];
  [connection.signal subscribeNext:^(id x) {
    
  }];
  //进行链接
  [connection connect];

}

- (void)loadData:(void(^)(id))success{
  
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
