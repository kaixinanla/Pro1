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
  [self loadData];
}

- (void)loadData {
  NSString *url = @"http://other.web.ra01.sycdn.kuwo.cn/resource/n3/128/17/55/3616442357.mp3";
  [GetNetWorkingTool getUrl:url body:nil result:ADJSON headerFile:nil success:^(id result) {
    
  } failture:^(NSError *error) {
    
  }];
}

- (void)goToAudioView {
  AudioPlayerViewController *vc = [[AudioPlayerViewController alloc] init];
  [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  
}


@end
