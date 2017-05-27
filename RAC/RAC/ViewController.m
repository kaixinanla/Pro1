//
//  ViewController.m
//  RAC
//
//  Created by 盛嘉 on 2017/5/27.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "ViewController.h"
#import "SJView.h"
#import "ReactiveCocoa.h"
//RACSubject：替代代理
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  SJView *v = [[SJView alloc]init];
  v.backgroundColor = [UIColor redColor];
  v.frame = CGRectMake(50, 50, 100, 100);
//  v.delegate = self;
  RACSubject *subject = [RACSubject subject];
  [subject subscribeNext:^(id x) {
    NSLog(@"点击了红色%@",x);
  }];
  v.subject = subject;
  [self.view addSubview:v];
 
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
- (void)viewWithTap:(SJView *)view{
  NSLog(@"点击了红色view");
}

@end
