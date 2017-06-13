//
//  HomeViewModel.m
//  RAC.4
//
//  Created by 盛嘉 on 2017/6/2.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "HomeViewModel.h"

@implementation HomeViewModel
- (RACCommand *)loadHomeDataCommand{
  if (_loadHomeDataCommand == nil) {
    //请求数据
    _loadHomeDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
      return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        return nil;
      }];
    }];
  }
  return _loadHomeDataCommand;
}
@end
