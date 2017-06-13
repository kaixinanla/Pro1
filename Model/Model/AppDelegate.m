//
//  AppDelegate.m
//  Model
//
//  Created by 盛嘉 on 2017/6/8.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "AppDelegate.h"
#import "WeiboSDK.h"
#define kAppKey @"1617942800"
#define kRedirectURI @"http://www.baidu.com"
#define LAST_RUN_VERSION_KEY @"last_run_version_of_application" 

#import "WeiboViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "XXLaunch.h"
#import "XXLaunchConfiguration.h"
#import "XXNotificationConfiguration.h"
@interface AppDelegate ()

@property (strong , nonatomic) XXLaunch *launch;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
//  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//  ViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewControllerActivity"];
//  
//  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
//  
//  self.window.rootViewController = navigationController;
//  
//  WeiboViewController *weiboViewController = [[WeiboViewController alloc] init];
//  weiboViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//  [navigationController presentViewController:weiboViewController animated:NO completion:nil];
//  
//  [navigationController.view addSubview:weiboViewController.view];
//  
//  weiboViewController.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//  
//  __weak AppDelegate *weakSelf = self;
//  
//  if ([self isFirstLoad]) {
//    NSLog(@"这是第一次运行");
//    self.startViewController = [[StartViewController alloc] initWithNibName:@"StartViewController" bundle:nil];
//    
//    self.startViewController.finishBlock = ^{
//      NSLog(@"视频播放完了的block通知");
//      
//      [weakSelf.startViewController.view removeFromSuperview];
//    };
//    
//    [navigationController.view addSubview:self.startViewController.view];
//    
// 
//    
//   }else{
//    NSLog(@"这是不是第一次运行");
//  }
  
   //APP 首次启动
  XXLaunchConfiguration *launchConf = nil;
  if ([self isFirstLoad]) {
    //视频启动图
    launchConf = [[XXLaunchConfiguration alloc]init];
    launchConf.style = XXLaunchStyleVideo;
    launchConf.launchVideoname = @"launch";
    launchConf.launchVideoType = @"mp4";
    launchConf.duration = 3.0f;
    launchConf.finishAnimate = XXLaunchFinishAnimateFadein;
  }else{
    //图片启动
    launchConf = [[XXLaunchConfiguration alloc] init];
    launchConf.style = XXLaunchStyleImage;
    launchConf.launchImageName = @"welcome";
    launchConf.adImageUrlString = @"";
    launchConf.duration = 3.0f;
    launchConf.finishAnimate = XXLaunchFinishAnimateFadein;
  }
   self.launch = [XXLaunch startXXLaunchWithConfiguration:launchConf
                                               didclickAd:^(){
     
                                             }
                                             willComplete:^(){
                                               [[NSNotificationCenter defaultCenter]postNotificationName:kXXLaunchCompletedNotification object:nil];
                                             }
                                                 complete:^(){
                                                   
                                                 }];
  
  
  
  return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#define LAST_RUN_VERSION_KEY @"last_run_version_of_application"
- (BOOL) isFirstLoad{
  NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary]
                              objectForKey:@"CFBundleShortVersionString"];
  
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  
  NSString *lastRunVersion = [defaults objectForKey:LAST_RUN_VERSION_KEY];
  
  if (!lastRunVersion) {
    [defaults setObject:currentVersion forKey:LAST_RUN_VERSION_KEY];
    return YES;
  }
  else if (![lastRunVersion isEqualToString:currentVersion]) {
    [defaults setObject:currentVersion forKey:LAST_RUN_VERSION_KEY];
    return YES;
  }
  return NO;
}

@end
