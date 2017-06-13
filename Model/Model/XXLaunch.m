//
//  XXLaunch.m
//  Model
//
//  Created by 盛嘉 on 2017/6/12.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "XXLaunch.h"
#import <AVFoundation/AVFoundation.h>
#import "XXLaunchConfiguration.h"
#import "ZFPlayer.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface XXLaunch () <ZFPlayerDelegate>

@property (strong , nonatomic) UIWindow *window;

@property (strong , nonatomic) UIView *launchVideoView;

@property (strong , nonatomic) ZFPlayerView *playerView;

@property (strong , nonatomic) UIImageView *launchImageView;

@property (strong , nonatomic) UIImageView *adImageView;

@property (strong , nonatomic) XXLaunchConfiguration *configuration;

@property (copy , nonatomic) XXLaunchAdClickBlock click;

@property (copy , nonatomic) XXLaunchDidCompleteBlock complete;

@property (copy , nonatomic) XXLaunchWillCompleteBlock willComplete;

@property (copy, nonatomic) dispatch_source_t waitDataTimer;

@property (copy , nonatomic) dispatch_source_t skipTimer;

@end
#define DISPATCH_SOURCE_CANCEL_SAFE(time) if(time)\
{\
dispatch_source_cancel(time);\
time = nil;\
}
static NSInteger defaultWaitDataDuration = 3;
@implementation XXLaunch
+ (XXLaunch *)startXXLaunchWithConfiguration:(nonnull XXLaunchConfiguration *)configuration
                                    didclickAd:(nullable XXLaunchAdClickBlock)click
                                willComplete:(nullable XXLaunchWillCompleteBlock)willComplete
                                    complete:(nullable XXLaunchDidCompleteBlock)complete{
  XXLaunch *launch = [[XXLaunch alloc]init];
  [launch startXXLaunchWithConfiguration:configuration
                                didClickAd:click
                            willComplete:willComplete
                                complete:complete];
  return launch;
}
- (void)startXXLaunchWithConfiguration:(nonnull XXLaunchConfiguration *)configuration
                              didClickAd:(nullable XXLaunchAdClickBlock)click
                          willComplete:(nullable XXLaunchWillCompleteBlock)willComplete
                              complete:(nullable XXLaunchDidCompleteBlock)complete
{
  if (configuration != nil && configuration.style == XXLaunchStyleVideo) {
    [self _videoLaunchWithConfiguration:configuration
                             didClickAd:click
                           willComplete:willComplete
                               complete:complete];
    return;
  }
}
- (void)_imageLaunchWithConfiguration:(nonnull XXLaunchConfiguration *)configuration
                           didClickAd:(nullable XXLaunchAdClickBlock)click
                         willComplete:(nullable XXLaunchWillCompleteBlock)willComplete
                             complete:(nullable XXLaunchDidCompleteBlock)complete{
  
}
- (void)_videoLaunchWithConfiguration:(nonnull XXLaunchConfiguration *)configuration
                           didClickAd:(nullable XXLaunchAdClickBlock)click
                         willComplete:(nullable XXLaunchWillCompleteBlock)willComplete
                             complete:(nullable XXLaunchDidCompleteBlock)complete{
  @weakify(self)
  if (configuration == nil) {[self remove];return;}
  _configuration = configuration;
  _click = click;
  _willComplete = willComplete;
  _complete = complete;
  
  //欢迎页图片
  if (configuration.launchVideoname.length > 0) {
    if (self.launchVideoView.superview) {
      [self.launchVideoView removeFromSuperview];
    }
    [self.window addSubview:self.launchVideoView];
    
    [self.launchVideoView mas_makeConstraints:^(MASConstraintMaker *make) {
      @strongify(self)
      make.edges.equalTo(self.window).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.playerView resetPlayer];
    ZFPlayerModel *playerModel = [[ZFPlayerModel alloc]init];
    NSString *thePath = [[NSBundle mainBundle]pathForResource:configuration.launchVideoname ofType:configuration.launchVideoType];
    playerModel.videoURL = [NSURL fileURLWithPath:thePath];
    playerModel.fatherView = self.launchVideoView;
    self.playerView.alpha = 1;
    UIView *controller = [[UIView alloc]init];
    [controller setBackgroundColor:[UIColor clearColor]];
    [self.playerView playerControlView:controller playerModel:playerModel];
    [self.playerView autoPlayTheVideo];
    
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:playerModel.videoURL options:opts];
    float second = 0;
    //总帧数/每秒帧数 = 视频长度
    second = urlAsset.duration.value/urlAsset.duration.timescale;
    
    //如果有视频，取视频时间和广告图时间最大的那个为等待时间
    NSTimeInterval duration = second;
    self.configuration.duration = MAX(duration, self.configuration.duration);
  }
  [self _startSkipDispathTimer];
}
- (instancetype)init{
  if (self = [super init]) {
    [self setupLaunchAd];
    [[NSNotificationCenter defaultCenter]addObserverForName:UIApplicationWillEnterForegroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
      
    }];
  }
  return self;
}
- (void)stop{
  [self removeAndanimate];
}

- (void)setupLaunchAd{
  UIWindow *window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
  window.rootViewController = [UIViewController new];
  window.rootViewController.view.backgroundColor = [UIColor clearColor];
  window.rootViewController.view.userInteractionEnabled = NO;
  window.windowLevel = UIWindowLevelStatusBar +1;
  window.hidden = NO;
  window.alpha = 1;
  self.window = window;
  
  [self _starWaitDataDispathTimer];
}
#pragma mark - remove
- (void)removeAndanimate{
  if (_willComplete != nil) {
    _willComplete();
  }
  XXLaunchFinishAnimate animation = XXLaunchFinishAnimateFadein;
  if(_configuration != nil) animation = _configuration.finishAnimate;
  if (animation == XXLaunchFinishAnimateLite)
  {
    [UIView animateWithDuration:1.5 animations:^{
      
      [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
      self.window.transform = CGAffineTransformMakeScale(2.f, 2.f);
      self.window.alpha = 0;
    }completion:^(BOOL finished) {
      [self remove];
    }];
  }
  else if(animation == XXLaunchFinishAnimateFadein){
    [UIView animateWithDuration:0.3 animations:^{
      self.window.alpha = 0;
    }completion:^(BOOL finished) {
      [self remove];
    }];
  }else{
    [self remove];
  }
}
- (void)remove{
  DISPATCH_SOURCE_CANCEL_SAFE(_waitDataTimer);
  DISPATCH_SOURCE_CANCEL_SAFE(_skipTimer);
  [self.window.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    [obj removeFromSuperview];
  }];
  self.window.hidden = YES;
  self.window = nil;
  
  if (_complete != nil) {
    _complete();
  }
}
#pragma mark - timer
- (void)_starWaitDataDispathTimer{
  __weak typeof (self)weakSelf = self;
  __block NSInteger duration =defaultWaitDataDuration;
  if(_waitDataTime) duration = _waitDataTime;
  NSTimeInterval period = 1.0;
  dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  _waitDataTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
  dispatch_source_set_timer(_waitDataTimer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0);
  dispatch_source_set_event_handler(_waitDataTimer, ^{
  dispatch_async(dispatch_get_main_queue(), ^{
    __strong typeof (self) strongSelf = weakSelf;
    
    if (duration ==0) {
      DISPATCH_SOURCE_CANCEL_SAFE(strongSelf.waitDataTimer);
      [strongSelf remove];return;
    }
    duration--;
  });
  });
  dispatch_resume(_waitDataTimer);
}
- (void)_startSkipDispathTimer{
  DISPATCH_SOURCE_CANCEL_SAFE(_waitDataTimer);
  __weak typeof (self) weakSelf = self;
  __block NSInteger duration = 3;
  if (_configuration.duration) duration = _configuration.duration;
  NSTimeInterval period = 1.0;
  dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  _skipTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
  dispatch_source_set_timer(_skipTimer, dispatch_walltime(NULL, 0), period *NSEC_PER_SEC, 0);
  dispatch_source_set_event_handler(_skipTimer, ^{
    dispatch_async(dispatch_get_main_queue(), ^{
      __strong typeof (self) strongSelf = weakSelf;
      if (duration == 0) {
        DISPATCH_SOURCE_CANCEL_SAFE(strongSelf.skipTimer);
        [strongSelf removeAndanimate];return ;
      }
      duration--;
    });

  });
  dispatch_resume(_skipTimer);
}
#pragma mark - action
- (void)ADClick:(id)sender{
  if (self.click) {
    self.click();
  }
}
#pragma mark -getter
- (UIView *)launchVideoView{
  if (!_launchVideoView) {
    _launchVideoView = [[UIView alloc]init];
    _launchVideoView.frame = [UIScreen mainScreen].bounds;
    _launchVideoView.backgroundColor = [UIColor clearColor];
    _launchVideoView.contentMode = UIViewContentModeScaleAspectFill;
    _launchVideoView.userInteractionEnabled = NO;
  }
  return _launchVideoView;
}
- (UIImageView *)launchImageView {
  if (!_launchImageView) {
    _launchImageView = [[UIImageView alloc] init];
    _launchImageView.frame = [UIScreen mainScreen].bounds;
    _launchImageView.backgroundColor = [UIColor clearColor];
    _launchImageView.contentMode = UIViewContentModeScaleAspectFill;
    _launchImageView.userInteractionEnabled = NO;
  }
  return _launchImageView;
}
- (ZFPlayerView *)playerView{
  if (!_playerView) {
    _playerView = [ZFPlayerView sharedPlayerView];
    _playerView.delegate = self;
    _playerView.cellPlayerOnCenter = NO;
    _playerView.stopPlayWhileCellNotVisable = YES;
  }
  return _playerView;
}
- (UIImageView *)adImageView{
  if (!_adImageView) {
    _adImageView = [[UIImageView alloc] init];
    _adImageView.frame = [UIScreen mainScreen].bounds;
    _adImageView.backgroundColor = [UIColor clearColor];
    _adImageView.contentMode = UIViewContentModeScaleAspectFill;
    _adImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ADClick:)];
    [_adImageView addGestureRecognizer:click];
  }
  return _adImageView;
}
#pragma mark - ZFPlayerDelegate


@end
