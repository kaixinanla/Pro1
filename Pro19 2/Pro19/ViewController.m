//
//  ViewController.m
//  Pro19
//
//  Created by 盛嘉 on 2017/5/17.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "ViewController.h"
#import "SSViewController.h"
@interface ViewController ()<UIScrollViewDelegate>
@property (strong , nonatomic) SSViewController *svc;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.svc = [[SSViewController alloc] initWithNibName:@"SSViewController" bundle:nil];
                [self.view addSubview:self.svc.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
