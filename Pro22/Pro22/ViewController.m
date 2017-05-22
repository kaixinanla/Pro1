//
//  ViewController.m
//  Pro22
//
//  Created by 盛嘉 on 2017/5/22.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "ViewController.h"
#import "FLTableViewController.h"
#import "Masonry.h"
@interface ViewController () <NSURLSessionDelegate>
@property (strong , nonatomic) FLTableViewController *fvc;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationController.navigationBar.translucent = NO;
  self.fvc = [[FLTableViewController alloc]initWithNibName:@"FLTableViewController" bundle:nil];
  [self.view addSubview:self.fvc.view];
  __weak typeof (self)weakSelf = self;
  [self.fvc.view mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
  }];
  

}

- (void)requestWelfareactivityByOffset:(NSString *)offset completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler{
  
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
