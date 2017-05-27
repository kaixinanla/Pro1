//
//  ViewController.m
//  GCD
//
//  Created by 盛嘉 on 2017/5/24.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
//  dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_SERIAL);
//  dispatch_queue_t queue1 = dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
//  [self syncConcurrent];
//  [self asyncConcurrent];
//  [self syncSerial];
//  [self asyncSerial];
//  [self barrier];
  [self dispatchApply];
  
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


- (void) syncConcurrent{
  NSLog(@"syncConcurrent-----begin");
  dispatch_queue_t queue = dispatch_queue_create("text.queue", DISPATCH_QUEUE_CONCURRENT);
  dispatch_sync(queue, ^{
    for (int i = 0; i < 2; i++) {
      NSLog(@"1------%@",[NSThread currentThread]);
    }
  });
  dispatch_sync(queue, ^{
    for (int i = 0; i < 2; i++) {
      NSLog(@"2------%@",[NSThread currentThread]);
    }
  });
  dispatch_sync(queue, ^{
    for (int i = 0; i < 2; i++) {
      NSLog(@"3------%@",[NSThread currentThread]);
    }
  });
  NSLog(@"syncConcurrent----end");
}
- (void) asyncConcurrent{
  NSLog(@"asyncConcurrent----begin");
  dispatch_queue_t queue =dispatch_queue_create("text", DISPATCH_QUEUE_CONCURRENT);
  dispatch_async(queue, ^{
    for (int i = 0 ; i < 2; i++) {
      NSLog(@"1-----%@",[NSThread currentThread]);
    }
  });
  dispatch_async(queue, ^{
    for (int i = 0 ; i < 2; i++) {
      NSLog(@"2-----%@",[NSThread currentThread]);
    }
  });
  dispatch_async(queue, ^{
    for (int i = 0 ; i < 2; i++) {
      NSLog(@"3-----%@",[NSThread currentThread]);
    }
  });
  NSLog(@"asyncConcurrent-----end");
}
- (void)syncSerial{
  NSLog(@"syncSerial--------begin");
  dispatch_queue_t queue = dispatch_queue_create("text.queue", DISPATCH_QUEUE_SERIAL);
  dispatch_sync(queue, ^{
    for (int i = 0; i < 2; i++) {
      NSLog(@"1------%@",[NSThread currentThread]);
    }
  });
  dispatch_sync(queue, ^{
    for (int i = 0; i < 2; i++) {
      NSLog(@"2------%@",[NSThread currentThread]);
    }
  });
  dispatch_sync(queue, ^{
    for (int i = 0; i < 2; i++) {
      NSLog(@"3------%@",[NSThread currentThread]);
    }
  });
  NSLog(@"syncSerial----end");
}
- (void)asyncSerial{
  NSLog(@"asyncSerial----begin");
  dispatch_queue_t queue = dispatch_queue_create("text.queue", DISPATCH_QUEUE_SERIAL);
  dispatch_async(queue, ^{
    for (int i = 0; i < 2; i++) {
      NSLog(@"1-----%@",[NSThread currentThread]);
    }
  });
  dispatch_async(queue, ^{
    for (int i = 0; i < 2; i++) {
      NSLog(@"2-----%@",[NSThread currentThread]);
    }
  });
  dispatch_async(queue, ^{
    for (int i = 0; i < 2; i++) {
      NSLog(@"3-----%@",[NSThread currentThread]);
    }
  });
  NSLog(@"asyncSerial---end");
}
- (void)syncMain
{
  NSLog(@"syncMain---begin");
  
  dispatch_queue_t queue = dispatch_get_main_queue();
  
  dispatch_sync(queue, ^{
    for (int i = 0; i < 2; ++i) {
      NSLog(@"1------%@",[NSThread currentThread]);
    }
  });
  dispatch_sync(queue, ^{
    for (int i = 0; i < 2; ++i) {
      NSLog(@"2------%@",[NSThread currentThread]);
    }
  });
  dispatch_sync(queue, ^{
    for (int i = 0; i < 2; ++i) {
      NSLog(@"3------%@",[NSThread currentThread]);
    }
  });
  
  NSLog(@"syncMain---end");
}
- (void)asyncMain
{
  NSLog(@"asyncMain---begin");
  
  dispatch_queue_t queue = dispatch_get_main_queue();
  
  dispatch_async(queue, ^{
    for (int i = 0; i < 2; ++i) {
      NSLog(@"1------%@",[NSThread currentThread]);
    }
  });
  dispatch_async(queue, ^{
    for (int i = 0; i < 2; ++i) {
      NSLog(@"2------%@",[NSThread currentThread]);
    }
  });
  dispatch_async(queue, ^{
    for (int i = 0; i < 2; ++i) {
      NSLog(@"3------%@",[NSThread currentThread]);
    }
  });
  
  NSLog(@"asyncMain---end");
}
- (void)barrier{
  dispatch_queue_t queue = dispatch_queue_create("12312312", DISPATCH_QUEUE_CONCURRENT);
  
  dispatch_async(queue, ^{
    NSLog(@"----1-----%@", [NSThread currentThread]);
  });
  dispatch_async(queue, ^{
    NSLog(@"----2-----%@", [NSThread currentThread]);
  });
  
  dispatch_barrier_async(queue, ^{
    NSLog(@"----barrier-----%@", [NSThread currentThread]);
  });
  
  dispatch_async(queue, ^{
    NSLog(@"----3-----%@", [NSThread currentThread]);
  });
  dispatch_async(queue, ^{
    NSLog(@"----4-----%@", [NSThread currentThread]);
  });
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    // 2秒后异步执行这里的代码...
    NSLog(@"run-----");
  });
}
- (void)dispatchApply {
  dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  
  dispatch_apply(6, queue, ^(size_t index) {
    NSLog(@"%zd------%@",index, [NSThread currentThread]);
  });
  
}
@end
