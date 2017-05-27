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
#import "FlagItem.h"
//数据优化，开启了一个异步线程去处理数据

//RAC集合:异步线程处理数据

//OC集合：数组，字典，NSSet
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"statedictionary.plist" ofType:nil];
  NSArray *datas = [NSArray arrayWithContentsOfFile:filePath];
//  datas = @[@1,@2,@3];
  //map:映射
  //mapBlock：value参数：集合。返回值：需要映射成哪个值
  [datas.rac_sequence map:^id(id value) {
    return [FlagItem itemWithDict:value];
  }];
  //转换RAC集合(RACSequence) 不能直接更新UI
//  NSMutableArray *arry = [NSMutableArray array];
//  [datas.rac_sequence.signal subscribeNext:^(id x) {
//    NSLog(@"%@",x);
//    FlagItem *item = [FlagItem itemWithDict:x];
//    [arry addObject:item];
//  }completed:^{
//    NSLog(@"%@",arry);
//  //
//  }];
  
  
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
