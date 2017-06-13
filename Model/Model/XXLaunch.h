//
//  XXLaunch.h
//  Model
//
//  Created by 盛嘉 on 2017/6/12.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XXLaunchConfiguration;
typedef void (^XXLaunchAdClickBlock)();
typedef void (^XXLaunchWillCompleteBlock)();
typedef void (^XXLaunchDidCompleteBlock)();
NS_ASSUME_NONNULL_BEGIN
@interface XXLaunch : NSObject
@property (nonatomic , assign) NSTimeInterval *waitDataTime;

+ (XXLaunch *)startXXLaunchWithConfiguration:(nonnull XXLaunchConfiguration *)configuration
                                    didclickAd:(nullable XXLaunchAdClickBlock)click
                                willComplete:(nullable XXLaunchWillCompleteBlock)willComplete
                                    complete:(nullable XXLaunchDidCompleteBlock)complete;

- (void)stop;

@end
NS_ASSUME_NONNULL_END
