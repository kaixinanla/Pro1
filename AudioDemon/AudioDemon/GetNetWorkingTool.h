//
//  GetNetWorkingTool.h
//  AudioDemon
//
//  Created by 盛嘉 on 2018/3/15.
//  Copyright © 2018年 盛嘉. All rights reserved.
//

#import <Foundation/Foundation.h>

//返回值的数据类型枚举
typedef enum :NSInteger {
  ADData,
  ADJSON,
  ADXML,
}ADResult;

// 网络请求Body的类型枚举
typedef enum : NSInteger {
  ADRequestJSON,
  ADRequestString,
}ADRequestStyle;
@interface GetNetWorkingTool : NSObject
//get 请求
+ (void)getUrl:(NSString *)url
          body:(id)body
        result:(ADResult)result
    headerFile:(NSDictionary *)headFile
       success:(void(^)(id result))success
      failture:(void(^)(NSError *error))failture;

//post 请求
+ (void)postUrl:(NSString *)url
           body:(id)body
         result:(ADResult)result
   requsetStyle:(ADRequestStyle)requestStyle
     headerFile:(NSDictionary *)headFile
        success:(void (^)(id))success
       failture:(void (^)(NSError *))failture;
@end
