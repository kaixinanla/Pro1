//
//  FlagItem.m
//  RAC
//
//  Created by 盛嘉 on 2017/5/27.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import "FlagItem.h"

@implementation FlagItem
+ (instancetype)itemWithDict:(NSDictionary *)dict{
  FlagItem *item = [[self alloc]init];
  [ item setValuesForKeysWithDictionary:dict];
  return item;
}
@end
