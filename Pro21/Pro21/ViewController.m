//
//  ViewController.m
//  Pro21
//
//  Created by 盛嘉 on 2017/5/20.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "ViewController.h"
#import "RSTableViewController.h"
#import "Masonry.h"

@interface ViewController ()
@property (strong , nonatomic)RSTableViewController *rvc;
@end

@implementation ViewController

- (void)viewDidLoad {
  self.navigationController.navigationBar.translucent = NO;
  [super viewDidLoad];
  self.rvc = [[RSTableViewController alloc]initWithNibName:@"RSTableViewController" bundle:nil];
  [self.view addSubview:self.rvc.view];
  __weak ViewController *weakSelf = self;
  [self.rvc.view mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
  }];
  
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
