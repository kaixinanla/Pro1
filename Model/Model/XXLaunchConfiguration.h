//
//  XXLaunchConfiguration.h
//  Model
//
//  Created by 盛嘉 on 2017/6/12.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class XXLaunch;

NS_ASSUME_NONNULL_BEGIN
typedef void (^XXSetupAdImageBlock)(XXLaunch *launch,UIImageView *ad,NSString *url);

typedef NS_ENUM(NSInteger , XXLaunchStyle){
  XXLaunchStyleImage = 0,
  XXLaunchStyleVideo = 1,
};

typedef  NS_ENUM(NSInteger , XXLaunchFinishAnimate){
  XXLaunchFinishAnimateNone = 1,
  XXLaunchFinishAnimateFadein = 2,
  XXLaunchFinishAnimateLite = 3
};
@interface XXLaunchConfiguration : NSObject

@property (assign , nonatomic) XXLaunchStyle style;

@property (copy , nonatomic) NSString *launchImageName;

@property (copy , nonatomic) NSString *launchVideoname;

@property (copy , nonatomic) NSString *launchVideoType;

@property (copy , nonatomic) NSString *adImageUrlString;

@property (copy , nonatomic) XXSetupAdImageBlock setupAdImage;

@property (nonatomic, assign) NSTimeInterval duration;

@property (assign , nonatomic) XXLaunchFinishAnimate finishAnimate;

+ (instancetype)defaultConfiguration;

+ (instancetype)launchConfiguration;


@end
NS_ASSUME_NONNULL_END
