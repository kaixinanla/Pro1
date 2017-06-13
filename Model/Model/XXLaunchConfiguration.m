//
//  XXLaunchConfiguration.m
//  Model
//
//  Created by 盛嘉 on 2017/6/12.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "XXLaunchConfiguration.h"
@interface XXLaunchConfiguration ()

@end
@implementation XXLaunchConfiguration
+ (instancetype)defaultConfiguration{
  XXLaunchConfiguration *conf= [[XXLaunchConfiguration alloc]init];
  conf.style = XXLaunchStyleImage;
  conf.launchImageName = @"Welcome";
  conf.adImageUrlString = @"";
  conf.duration = 3.0f;
  conf.finishAnimate = XXLaunchFinishAnimateFadein;
  return conf;
  
}
+ (instancetype)launchConfiguration{
  XXLaunchConfiguration *conf = [[XXLaunchConfiguration alloc]init];
  conf.style = XXLaunchStyleImage;
  conf.launchImageName = @"Welcome";
  conf.adImageUrlString = @"";
  conf.duration = 3.0f;
  conf.finishAnimate = XXLaunchFinishAnimateFadein;
  return conf;
}

- (instancetype)init{
  if (self=  [super init]) {
    self.style = XXLaunchStyleImage;
    self.duration = 3.0f;
    self.finishAnimate = XXLaunchFinishAnimateFadein;
  }
  return self;
}
@end
