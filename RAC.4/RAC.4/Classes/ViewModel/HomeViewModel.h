//
//  HomeViewModel.h
//  RAC.4
//
//  Created by 盛嘉 on 2017/6/2.
//  Copyright © 2017年 盛嘉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"
@interface HomeViewModel : NSObject
{
  RACCommand *_loadHomeDataCommand;
}
@property (strong , nonatomic, readonly)RACCommand *loadHomeDataCommand;
//- (void)loadData;
@end
