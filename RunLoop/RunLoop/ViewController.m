//
//  ViewController.m
//  RunLoop
//
//  Created by 盛嘉 on 2017/5/24.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak , nonatomic) IBOutlet UIImageView *imageView;
@property (strong , nonatomic) NSThread *thread;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
//  CFRunLoopGetCurrent();
//  NSLog(@"---------%@",[NSThread currentThread]);
  //定义一个定时器，约定两秒之后调用self的run方法
 // NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
  //[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
  //将定时器添加到当前RunLoop的NSDefaultRunLoopMode下
  //[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
 
 
  
  //创建观察者
//  CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
//    NSLog(@"监听到RunLoop发生改变---%zd",activity);
//  });
//  
//  
//  //监听观察者到当前RunLoop中
//  CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
//  
//  //释放observer, 最后添加完需要释放掉
//  CFRelease(observer);
//  
  self.thread = [[NSThread alloc]initWithTarget:self selector:@selector(run1) object:nil];
  [self.thread start];
}
- (void)run{
  NSLog(@"-----run");
}
- (void)run1{
  NSLog( @"------run1------");
    // 添加下边两句代码，就可以开启RunLoop，之后self.thread就变成了常驻线程，可随时添加任务，并交于RunLoop处理
  [[NSRunLoop currentRunLoop]addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
  [[NSRunLoop currentRunLoop] run];
  NSLog(@"未开启Runloop");
}
- (void)run2{
  NSLog(@"-------run2------");
}
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
- (IBAction)BtnClick:(id)sender {
  NSLog(@".........");
}
- (void)showImage{
 [self.imageView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"tupian.jpg"] afterDelay:4.0 inModes:@[NSDefaultRunLoopMode]];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//  [self showImage];
  [self performSelector:@selector(run2) onThread:self.thread withObject:nil waitUntilDone:NO];
  
}
@end
