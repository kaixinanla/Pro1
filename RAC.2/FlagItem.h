//
//  FlagItem.h
//  RAC
//
//  Created by 盛嘉 on 2017/5/27.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlagItem : NSObject
@property (strong , nonatomic) NSString *name;
@property (strong , nonatomic) NSString *icon;



+ (instancetype)itemWithDict:(NSDictionary *)dict;
@end
