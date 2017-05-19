//
//  ViewController.m
//  Pro18
//
//  Created by 盛嘉 on 2017/5/17.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "ViewController.h"
#import "HLTableViewController.h"
#import "Masonry.h"
@interface ViewController ()<UITabBarDelegate,UITableViewDataSource>
@property (strong , nonatomic)HLTableViewController *HLvc;
@end

@implementation ViewController

- (void)viewDidLoad {
    self.navigationController.navigationBar.translucent = NO;
    [super viewDidLoad];
    self.HLvc = [[HLTableViewController alloc]initWithNibName:@"HLTableViewController" bundle:nil];
    [self.view addSubview:self.HLvc.view];
    __weak ViewController *weakSelf = self;
    [self.HLvc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
