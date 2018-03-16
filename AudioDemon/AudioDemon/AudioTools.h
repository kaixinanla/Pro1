//
//  AudioTools.h
//  AudioDemon
//
//  Created by 盛嘉 on 2018/3/14.
//  Copyright © 2018年 盛嘉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FSAudioStream.h>

@interface AudioTools : NSObject

@property (nonatomic, strong) NSDictionary *audioDic;

+ (AudioTools *)shareInstance;
- (FSAudioStream *)playerInit;
- (void)stop;
- (void)play;
- (void)backProgress;
@end
