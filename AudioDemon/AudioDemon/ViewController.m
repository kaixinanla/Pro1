//
//  ViewController.m
//  AudioDemon
//
//  Created by 盛嘉 on 2018/3/14.
//  Copyright © 2018年 盛嘉. All rights reserved.
//

#import "ViewController.h"
#import "AudioPlayerViewController.h"
#import "GetNetWorkingTool.h"

@interface ViewController ()
@property (nonatomic, strong) UIButton *jumpButton;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  self.jumpButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 20, 20)];
  self.jumpButton.backgroundColor = [UIColor blackColor];
  [self.view addSubview:self.jumpButton];
  [self.jumpButton addTarget:self action:@selector(goToAudioView) forControlEvents:UIControlEventTouchUpInside];
}

- (void)goToAudioView {
  AudioPlayerViewController *vc = [[AudioPlayerViewController alloc] init];
  UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
  [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  
}


@end
