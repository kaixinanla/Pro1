//
//  ViewController.m
//  Pro20.1
//
//  Created by 盛嘉 on 2017/5/19.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "ViewController.h"
#import "SJCollectionViewController.h"
@interface ViewController ()<UICollectionViewDelegate , UICollectionViewDataSource>
@property (strong , nonatomic) SJCollectionViewController *svc;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.svc = [[SJCollectionViewController alloc] initWithNibName:@"SJCollectionViewController" bundle:nil];
    [self.view addSubview:self.svc.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
