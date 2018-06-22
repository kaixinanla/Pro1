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
#import <Lottie/Lottie.h>

@interface ViewController ()
@property (nonatomic, strong) UIButton *jumpButton;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) LOTAnimationView *lottieLogo;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  self.jumpButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 20, 20)];
  self.jumpButton.backgroundColor = [UIColor blackColor];
  [self.view addSubview:self.jumpButton];
  [self.jumpButton addTarget:self action:@selector(goToAudioView) forControlEvents:UIControlEventTouchUpInside];
  self.lottieLogo = [LOTAnimationView animationNamed:@"Boat_Loader"];
  self.lottieLogo.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  self.lottieLogo.contentMode = UIViewContentModeScaleAspectFill;
  self.lottieLogo.loopAnimation = YES;
  [self.view addSubview:self.lottieLogo];
  
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_playLottieAnimation)];
  self.lottieLogo.userInteractionEnabled = YES;
  [self.lottieLogo addGestureRecognizer:tap];
}

- (void)_playLottieAnimation {
  self.lottieLogo.animationProgress = 0;
  [self.lottieLogo play];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  CGRect lottieRect = CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height * 0.3);
//  self.lottieLogo.frame = lottieRect;
  self.lottieLogo.frame = self.view.bounds;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.lottieLogo play];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  [self.lottieLogo pause];
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
