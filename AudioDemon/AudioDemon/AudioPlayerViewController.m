//
//  AudioPlayerViewController.m
//  AudioDemon
//
//  Created by 盛嘉 on 2018/3/14.
//  Copyright © 2018年 盛嘉. All rights reserved.
//

#import "AudioPlayerViewController.h"
#import <Masonry.h>
#import <FSAudioStream.h>
#import "AudioTools.h"


@interface AudioPlayerViewController ()

@property (nonatomic, strong) FSAudioStream *audioStream;
@property (nonatomic, assign) CGFloat playbackTime;
@property (nonatomic, strong) NSTimer *playerTimer;
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong) UIImageView *audioTitleImage;
@property (nonatomic, strong) UILabel *nowTimeLabel;
@property (nonatomic, strong) UILabel *totalTimeLabel;
@property (nonatomic, strong) UIProgressView *playerProgress;
@property (nonatomic, strong) UISlider *sliderProgress;
@property (nonatomic, assign) BOOL isSliding;
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, assign) CGFloat playheadTime;
@property (nonatomic, assign) CGFloat totalTime;
@property (nonatomic, strong) UIButton *lastButton;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIButton *rewindButton;
@property (nonatomic, strong) UIButton *forwardButton;
@property (nonatomic, strong) UIButton *lowRateButton;
@property (nonatomic, strong) UIButton *normalRateButton;
@property (nonatomic, strong) UIButton *moreRateButton;
@property (nonatomic, strong) UIButton *mostRateButton;
@property (nonatomic, assign) ADStreamerState state;

@end

@implementation AudioPlayerViewController
{
  CGFloat playerRate;
}
- (void)viewDidLoad {
    [super viewDidLoad];
  self.view.backgroundColor = [UIColor colorWithRed:0.26 green:0.26 blue:0.26 alpha:1.00];
  [self initialized];
  [self initSubviews];
}

- (void)initialized {
  self.audioStream = [[AudioTools shareInstance] playerInit];
  self.audioStream.url = [NSURL URLWithString:@"http://other.web.ra01.sycdn.kuwo.cn/resource/n3/128/17/55/3616442357.mp3"];
  __weak typeof(self) weakSelf = self;
  self.state = ADIdle;
  [self.audioStream setVolume:1];
  [self.audioStream play];
  self.audioStream.onFailure = ^(FSAudioStreamError error, NSString *description) {
    if (error == kFsAudioStreamErrorNone) {
      NSLog(@"播放出现问题");
    }else if (error == kFsAudioStreamErrorNetwork){
      NSLog(@"请检查网络连接");
    }
  };
  
  self.audioStream.onCompletion = ^{
    [weakSelf nextButtonAction];
  };
  
  self.isPlaying = YES;
  //self.playerTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(playProgressAction) userInfo:nil repeats:YES];
  dispatch_queue_t queue = dispatch_get_main_queue();
  self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
  dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
  uint64_t interval = (uint64_t)(1.0 * NSEC_PER_SEC);
  dispatch_source_set_timer(self.timer, start, interval, 0);
  dispatch_source_set_event_handler(self.timer, ^{
    [weakSelf playProgressAction];
  });
  dispatch_resume(self.timer);
}

- (void)initSubviews {
  __weak AudioPlayerViewController *weakself = self;
  
  _audioTitleImage = [[UIImageView alloc] init];
  _audioTitleImage.contentMode = UIViewContentModeScaleAspectFill;
  _audioTitleImage.clipsToBounds  = YES;
  [self.view addSubview:_audioTitleImage];
  [self.audioTitleImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(weakself.view.mas_centerX);
    make.top.mas_equalTo (60);
    make.width.height.mas_equalTo(235);
  }];
  
  _nowTimeLabel = [[UILabel alloc] init];
  _nowTimeLabel.numberOfLines = 1;
  _nowTimeLabel.font = [UIFont systemFontOfSize:14];
  _nowTimeLabel.textAlignment = NSTextAlignmentCenter;
  _nowTimeLabel.textColor = [UIColor blackColor];
  [self.view addSubview:_nowTimeLabel];
  [self.nowTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(60);
    make.top.mas_equalTo(weakself.audioTitleImage.mas_bottom).offset(40);
    make.width.mas_equalTo(50);
    make.height.mas_equalTo(10);
  }];

  _playerProgress = [[UIProgressView alloc] init];
  _playerProgress.transform = CGAffineTransformMakeScale(1.0f,1.0f);
  _playerProgress.tintColor = [UIColor blackColor];
  [self.view addSubview:self.playerProgress];
  [self.playerProgress mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(60);
    make.centerY.mas_equalTo(weakself.view.mas_centerY);
    make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width - 130);
    make.height.mas_equalTo(2);
  }];

  _sliderProgress = [[UISlider alloc] init];
  _sliderProgress.value = 0.f;
  _sliderProgress.continuous = YES;
  _sliderProgress.tintColor = [UIColor orangeColor];
  _sliderProgress.maximumTrackTintColor = [UIColor clearColor];
  [_sliderProgress addTarget:self action:@selector(durationSliderTouch:) forControlEvents:UIControlEventValueChanged];
  [_sliderProgress addTarget:self action:@selector(durationSliderTouchEnded:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:_sliderProgress];
  [self.sliderProgress mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(60);
    make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width - 130);
    make.top.mas_equalTo(weakself.playerProgress.mas_top).offset(-10);
    make.height.mas_equalTo(20);
  }];
  
  _totalTimeLabel = [[UILabel alloc] init];
  _totalTimeLabel.numberOfLines = 1;
  _totalTimeLabel.font = [UIFont systemFontOfSize:14];
  _totalTimeLabel.text = @"00:00";
  _totalTimeLabel.textAlignment = NSTextAlignmentCenter;
  _totalTimeLabel.textColor = [UIColor blackColor];
  [self.view addSubview:_totalTimeLabel];
  [self.totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(weakself.sliderProgress.mas_right).offset(0);
    make.top.mas_equalTo(weakself.audioTitleImage.mas_bottom).offset(40);
    make.width.mas_equalTo(50);
    make.height.mas_equalTo(10);
  }];

  _lastButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [_lastButton setImage:[UIImage imageNamed:@"lastSong"] forState:UIControlStateNormal];
  [_lastButton addTarget:self action:@selector(lastButtonAction) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:_lastButton];
  [self.lastButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(100);
    make.top.mas_equalTo(weakself.totalTimeLabel.mas_bottom).offset(90);
    make.width.height.mas_equalTo(40);
  }];

  _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [_nextButton setImage:[UIImage imageNamed:@"nextSong"] forState:UIControlStateNormal];
  [_nextButton addTarget:self action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:_nextButton];
  [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.mas_equalTo(-100);
    make.top.mas_equalTo(weakself.totalTimeLabel.mas_bottom).offset(90);
    make.width.height.mas_equalTo(40);
  }];

  _rewindButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [_rewindButton setImage:[UIImage imageNamed:@"lastSong"] forState:UIControlStateNormal];
  _rewindButton.backgroundColor = [UIColor blueColor];
  [_rewindButton addTarget:self action:@selector(rewindButtonAction) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:_rewindButton];
  [self.rewindButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(50);
    make.top.mas_equalTo(weakself.totalTimeLabel.mas_bottom).offset(90);
    make.width.height.mas_equalTo(40);
  }];

  _forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [_forwardButton setImage:[UIImage imageNamed:@"nextSong"] forState:UIControlStateNormal];
  [_forwardButton addTarget:self action:@selector(forwardButtonAction) forControlEvents:UIControlEventTouchUpInside];
  _forwardButton.backgroundColor = [UIColor blueColor];
  [self.view addSubview:_forwardButton];
  [self.forwardButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(weakself.nextButton.mas_right);
    make.top.mas_equalTo(weakself.totalTimeLabel.mas_bottom).offset(90);
    make.width.height.mas_equalTo(40);
  }];
  
  _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [_playButton setImage:[UIImage imageNamed:@"audioPause"] forState:UIControlStateNormal];
  [_playButton addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:_playButton];
  [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.mas_equalTo(weakself.view.mas_centerX);
    make.top.mas_equalTo(weakself.totalTimeLabel.mas_bottom).offset(90);
    make.width.height.mas_equalTo(40);
  }];
  
  _lowRateButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [_lowRateButton setTitle:@"0.5" forState:UIControlStateNormal];
  [_lowRateButton addTarget:self action:@selector(lowRateChange) forControlEvents:UIControlEventTouchUpInside];
  _lowRateButton.backgroundColor = [UIColor blueColor];
  [self.view addSubview:_lowRateButton];
  [self.lowRateButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(40);
    make.top.mas_equalTo(weakself.totalTimeLabel.mas_bottom).offset(150);
    make.width.height.mas_equalTo(30);
  }];
  
  _normalRateButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [_normalRateButton addTarget:self action:@selector(normalRateChange) forControlEvents:UIControlEventTouchUpInside];
  [_normalRateButton setTitle:@"1.0" forState:UIControlStateNormal];
  _normalRateButton.backgroundColor = [UIColor blueColor];
  [self.view addSubview:_normalRateButton];
  [self.normalRateButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(weakself.lowRateButton.mas_right).offset(20);
    make.top.mas_equalTo(weakself.totalTimeLabel.mas_bottom).offset(150);
    make.width.height.mas_equalTo(30);
  }];
  
  _moreRateButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [_moreRateButton addTarget:self action:@selector(moreRateChange) forControlEvents:UIControlEventTouchUpInside];
  [_moreRateButton setTitle:@"1.5" forState:UIControlStateNormal];
  _moreRateButton.backgroundColor = [UIColor blueColor];
  [self.view addSubview:_moreRateButton];
  [self.moreRateButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(weakself.normalRateButton.mas_right).offset(20);
    make.top.mas_equalTo(weakself.totalTimeLabel.mas_bottom).offset(150);
    make.width.height.mas_equalTo(30);
  }];
  
  _mostRateButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [_mostRateButton addTarget:self action:@selector(mostRateChange) forControlEvents:UIControlEventTouchUpInside];
  [_mostRateButton setTitle:@"2.0" forState:UIControlStateNormal];
  _mostRateButton.backgroundColor = [UIColor blueColor];
  [self.view addSubview:_mostRateButton];
  [self.mostRateButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(weakself.moreRateButton.mas_right).offset(20);
    make.top.mas_equalTo(weakself.totalTimeLabel.mas_bottom).offset(150);
    make.width.height.mas_equalTo(30);
  }];
  
  UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
  closeButton.backgroundColor = [UIColor redColor];
  [closeButton setFrame:CGRectMake(0, 0, 23, 23)];
  [closeButton addTarget:self action:@selector(closeViewController) forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
  self.navigationItem.leftBarButtonItems = @[closeItem];
}

#pragma 进度条更新
- (void)playProgressAction {
  FSStreamPosition cur = self.audioStream.currentTimePlayed;
  self.playbackTime =cur.playbackTimeInSeconds/1;
  double minutesElapsed = floor(fmod(self.playbackTime/ 60.0,60.0));
  double secondsElapsed = floor(fmod(self.playbackTime,60.0));
  self.nowTimeLabel.text = [NSString stringWithFormat:@"%02.0f:%02.0f",minutesElapsed, secondsElapsed];
  if (self.isSliding == YES) {
    
  }else{
    self.sliderProgress.value = cur.position;//播放进度
    [self updateSliderUI:self.sliderProgress];
  }
  // 总时长
  self.totalTime = self.playbackTime/cur.position;
  if ([[NSString stringWithFormat:@"%f",self.totalTime] isEqualToString:@"nan"]) {
    self.totalTimeLabel.text = @"00:00";
  }else {
    double minutesElapsed1 = floor(fmod(self.totalTime/60.0,60.0));
    double secondsElapsed1 = floor(fmod(self.totalTime,60.0));
    self.totalTimeLabel.text = [NSString stringWithFormat:@"%02.0f:%02.0f",minutesElapsed1, secondsElapsed1];
  }
  //
  float  prebuffer = (float)self.audioStream.prebufferedByteCount;
  float contentlength = (float)self.audioStream.contentLength;
  if (contentlength>0) {
    self.playerProgress.progress = prebuffer /contentlength;//缓存进度
    self.playerProgress.progressTintColor = [UIColor redColor];
    //NSLog(@"------%f-----%f",prebuffer,contentlength);
  }
}

- (void)durationSliderTouch:(UISlider *)slider{
  self.isSliding = YES;
  FSStreamPosition cur = self.audioStream.currentTimePlayed;
  self.playbackTime =cur.playbackTimeInSeconds/1;
  float sliderBackTime = self.totalTime * slider.value ;
  double minutesElapsed = floor(fmod(sliderBackTime/ 60.0,60.0));
  double secondsElapsed = floor(fmod(sliderBackTime, 60.0));
  self.nowTimeLabel.text = [NSString stringWithFormat:@"%02.0f:%02.0f",minutesElapsed, secondsElapsed];
  [self updateSliderUI:slider];
}

- (void)reloadprogressValue{
  self.isSliding = NO;
}

- (void)durationSliderTouchEnded:(UISlider *)slider {
  [self performSelector:@selector(reloadprogressValue) withObject:self afterDelay:0.5];
  [self touchSliderToPlay:slider.value];
}

- (void)touchSliderToPlay:(CGFloat)time {
  if (time == 1) {
    [self nextButtonAction];
  }else if (time >= 0) {
    FSStreamPosition pos = {0};
    pos.position = time;
    [self.audioStream seekToPosition:pos];
  }
}

#pragma mark 播放暂停系列操作
- (void)playAction {
  if (self.isPlaying == YES) {
    [self.audioStream pause];
    [self.playerTimer setFireDate:[NSDate distantFuture]];
    [_playButton setImage:[UIImage imageNamed:@"bofang"] forState:UIControlStateNormal];
  }else {
    [self.audioStream pause];
    [self.playerTimer setFireDate:[NSDate distantPast]];
    [_playButton setImage:[UIImage imageNamed:@"audioPause"] forState:UIControlStateNormal];
  }
  self.isPlaying = !self.isPlaying;
}

- (void)nextButtonAction {
  self.audioStream.url = [NSURL URLWithString:@"http://music.163.com/song/media/outer/url?id=108810.mp3"];
  [self.audioStream play];
}

- (void)lastButtonAction {
  self.audioStream.url = [NSURL URLWithString:@"http://music.163.com/song/media/outer/url?id=476592630.mp3"];
  [self.audioStream play];
}

- (void)rewindButtonAction {
  [self.audioStream play];
  float bkp = 15 / self.totalTime;
  float finalPostion = self.sliderProgress.value - bkp;
  FSStreamPosition pos = {0};
  pos.position = finalPostion;
  [self.audioStream seekToPosition:pos];
}

- (void)forwardButtonAction {
  [self.audioStream play];
  float gkp = 15 / self.totalTime;
  float finalPostion = self.sliderProgress.value + gkp;
  FSStreamPosition pos = {0};
  pos.position = finalPostion;
  [self.audioStream seekToPosition:pos];
}

#pragma mark - streamerPlayRate

- (void)lowRateChange {
  self.state = ADLowState;
  [self.audioStream setPlayRate:0.5];
}

- (void)normalRateChange {
  self.state = ADNormalState;
  [self.audioStream setPlayRate:1.0];
}

- (void)moreRateChange {
  self.state = ADMoreState;
  [self.audioStream setPlayRate:1.5];
}

- (void)mostRateChange {
  self.state = ADMostState;
  [self.audioStream setPlayRate:2.0];
}

#pragma mark - UISliderUI
- (void)updateSliderUI:(UISlider *)slider{
  __weak AudioPlayerViewController *weakself = self;
  CGFloat leftDistance = ([UIScreen mainScreen].bounds.size.width - 130) * slider.value;
  [self.nowTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(leftDistance + 60);
    make.top.mas_equalTo(weakself.sliderProgress.mas_bottom).offset(15);
    make.width.mas_equalTo(50);
    make.height.mas_equalTo(10);
  }];
}
- (void)closeViewController {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc{
  NSLog(@"音频播放释放");
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillDisappear:(BOOL)animated{
  [super viewWillDisappear:animated];
 // [self.playerTimer invalidate];
  [self playerItemDealloc];
}

- (void)playerItemDealloc{
  NSArray *arr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:_audioStream.configuration.cacheDirectory error:nil];
  for (NSString *file in arr) {
    if ([file hasPrefix:@"FSCache-"]) {
      NSString *path = [NSString stringWithFormat:@"%@/%@", _audioStream.configuration.cacheDirectory, file];
      [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
  }
  [self.audioStream stop];
  _audioStream = nil;
}
@end
