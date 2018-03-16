//
//  AudioPlayerViewController.h
//  AudioDemon
//
//  Created by 盛嘉 on 2018/3/14.
//  Copyright © 2018年 盛嘉. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ADStreamerState) {
  ADIdle              = 1,      //
  ADLowState          = 2,      //
  ADNormalState       = 3,      //
  ADMoreState         = 4,      //
  ADMostState         = 5,      //
};

@interface AudioPlayerViewController : UIViewController

@property (nonatomic, strong) NSDictionary *singDic;
@end
