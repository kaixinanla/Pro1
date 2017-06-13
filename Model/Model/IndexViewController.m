//
//  IndexViewController.m
//  Model
//
//  Created by 盛嘉 on 2017/6/12.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "IndexViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "XXNotificationConfiguration.h"
#import "WeiboViewController.h"
@interface IndexViewController ()

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   @weakify(self)
             
 [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kXXLaunchCompletedNotification object:nil]subscribeNext:^(id x) {
   WeiboViewController *weiboViewController = [[WeiboViewController alloc]initWithNibName:@"WeiboViewController" bundle:nil];
   [self presentViewController:weiboViewController animated:NO completion:^{
    
   }];
  }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
