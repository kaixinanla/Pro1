//
//  GetNetWorkingTool.m
//  AudioDemon
//
//  Created by 盛嘉 on 2018/3/15.
//  Copyright © 2018年 盛嘉. All rights reserved.
//

#import "GetNetWorkingTool.h"
#import <AFNetworking.h>

@implementation GetNetWorkingTool

+ (void)getUrl:(NSString *)url
          body:(id)body
        result:(ADResult)result
    headerFile:(NSDictionary *)headFile
       success:(void (^)(id))success
      failture:(void (^)(NSError *))failture {
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  
  if (headFile) {
    for (NSString *key in headFile.allKeys) {
      [manager.requestSerializer setValue:headFile[key] forHTTPHeaderField:key];
    }
  }
  
  switch (result) {
    case ADData:
      ///返回NSData
      manager.responseSerializer = [AFHTTPResponseSerializer serializer];
      break;
    case ADJSON:
      ///返回JSON
      manager.responseSerializer = [AFHTTPResponseSerializer serializer];
      break;
    case ADXML:
      ///返回XML
      manager.responseSerializer = [AFHTTPResponseSerializer serializer];
      break;
    default:
      break;
  }
  
  [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", nil]];
  [manager GET:url parameters:body progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    if (responseObject) {
      success(responseObject);
    }
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    if (error) {
      failture(error);
    }
  }];
  
}

+ (void)postUrl:(NSString *)url
           body:(id)body
         result:(ADResult)result
   requsetStyle:(ADRequestStyle)requestStyle
     headerFile:(NSDictionary *)headFile
        success:(void (^)(id))success
       failture:(void (^)(NSError *))failture {
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  
  switch (requestStyle) {
    case ADRequestJSON:
      manager.responseSerializer = [AFHTTPResponseSerializer serializer];
      break;
    case ADRequestString:
      [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
        return parameters;
      }];
      break;
    default:
      break;
  }
  
  switch (result) {
    case ADData:
      ///返回NSData
      manager.responseSerializer = [AFHTTPResponseSerializer serializer];
      break;
    case ADJSON:
      ///返回JSON
      manager.responseSerializer = [AFHTTPResponseSerializer serializer];
      break;
    case ADXML:
      ///返回XML
      manager.responseSerializer = [AFHTTPResponseSerializer serializer];
      break;
    default:
      break;
  }
  
  [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", nil]];
  [manager POST:url parameters:body progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    if (responseObject) {
      success(responseObject);
    }
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    if (error) {
      failture(error);
    }
  }];
}
@end
