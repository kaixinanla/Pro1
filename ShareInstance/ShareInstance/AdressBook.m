//
//  AdressBook.m
//  ShareInstance
//
//  Created by 盛嘉 on 2017/5/25.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "AdressBook.h"
static AdressBook *instance = nil; //并不能让外部访问，同时放在静态块中
@implementation AdressBook
//+ (instancetype)shareInstance{
//  if (instance == nil) {
//    instance = [[AdressBook alloc]init];
//  }
//  return instance;
//}
//+ (instancetype)allocWithZone:(struct _NSZone *)zone{
//  if (instance == nil) {
//    instance = [super allocWithZone:zone];
//  }
//  return instance;
//}
//- (instancetype)copy{
//  return self;
//}

//+ (instancetype)shareInstance{
//  static dispatch_once_t onceToken;
//  dispatch_once(&onceToken, ^{
//    instance = [[AdressBook alloc]init];
//  });
//  return instance;
//}
//+ (instancetype)allocWithZone:(struct _NSZone *)zone{
//  static dispatch_once_t onceToken;
//  dispatch_once(&onceToken, ^{
//    instance = [super allocWithZone:zone];
//  });
//  return instance;
//}
//+ (instancetype) shareInstance{
//  @synchronized (self) {
//    if (instance == nil) {
//      instance=  [[AdressBook alloc]init];
//    }
//  }
//  return instance;
//}
//+ (instancetype) allocWithZone:(struct _NSZone *)zone{
//  if (instance == nil) {
//    instance = [super allocWithZone:zone];
//  }
//  return instance;
//}
//+ (instancetype)shareInstance{
//  static dispatch_once_t onceToken;
//  dispatch_once(&onceToken, ^{
//    instance = [[AdressBook alloc]init];
//  });
//  return instance;
//}
//+ (instancetype)allocWithZone:(struct _NSZone *)zone{
//  static dispatch_once_t onceToken;
//  dispatch_once(&onceToken, ^{
//    instance = [super allocWithZone:zone];
//    });
//  return instance;
//}

@end
