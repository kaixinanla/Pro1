//
//  AudioTools.m
//  AudioDemon
//
//  Created by 盛嘉 on 2018/3/14.
//  Copyright © 2018年 盛嘉. All rights reserved.
//

#import "AudioTools.h"

@interface AudioTools ()

@property (nonatomic, strong) FSAudioStream *audioStream;
@end
@implementation AudioTools

+ (AudioTools *)shareInstance {
  static dispatch_once_t oneToken;
  static id shareInstance;
  dispatch_once(&oneToken, ^{
    shareInstance = [[self alloc] init];
  });
  return shareInstance;
}

- (FSAudioStream *)playerInit {
  if (_audioStream == nil ) {
    FSStreamConfiguration *config = [[FSStreamConfiguration alloc] init];
    config.httpConnectionBufferSize *= 2;
    config.enableTimeAndPitchConversion = YES;
    _audioStream=[[FSAudioStream alloc] initWithConfiguration:config];
    [_audioStream setVolume:1];
  }
  return _audioStream;
}
@end
