//
//  ViewController.m
//  RACCommand.2
//
//  Created by 盛嘉 on 2017/6/1.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveCocoa.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
//  _loginButton.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input)
//  {
//    NSLog(@"点击了按钮",input);
//    
//    
//    
//     return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//       [subscriber sendNext:input];
//       return nil;
//     }];
//  }];
  RACSubject *enableSignal = [RACSubject subject];
  _loginButton.rac_command = [[RACCommand alloc]initWithEnabled:enableSignal signalBlock:^RACSignal *(id input) {
    NSLog(@"点击了按钮%@",input);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
      [subscriber sendNext:input];
     //  [subscriber sendCompleted];
      return nil;
    }];
  }];
  //[enableSignal sendNext:@(NO)];
  [[_loginButton.rac_command.executing skip:1] subscribeNext:^(id x) {
    BOOL executing =[x boolValue];
    [enableSignal sendNext:@(!executing)];
  }];
  
  
  
  
  //监听
  
  [_loginButton.rac_command.executionSignals.switchToLatest subscribeNext:^(id x) {
    NSLog(@"%@",x);
  
  }];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
