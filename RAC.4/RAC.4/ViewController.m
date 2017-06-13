//
//  ViewController.m
//  RAC.4
//
//  Created by 盛嘉 on 2017/6/2.
//  Copyright © 2017年 盛嘉. All rights reserved.
//
//RAC + MVVM
//RACCommand:请求数据
#import "ViewController.h"
#import "HomeViewModel.h"
@interface ViewController ()

@property (strong , nonatomic) HomeViewModel *homeVM;
@end

@implementation ViewController

- (HomeViewModel *)homeVM{
  if (_homeVM == nil) {
    _homeVM = [[HomeViewModel alloc]init];
  }
  return _homeVM;
}

- (void)viewDidLoad {
  [super viewDidLoad];
 //请求数据
  //[self.homeVM loadData];
  [self.homeVM.loadHomeDataCommand execute:nil];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
