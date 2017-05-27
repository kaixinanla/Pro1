//
//  ViewController.m
//  Pro24
//
//  Created by 盛嘉 on 2017/5/23.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "ViewController.h"
#import "Myoperation.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  Myoperation *op1 = [[Myoperation alloc]init];
  [op1 start];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
