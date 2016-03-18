//
//  CDHttpService.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/17.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDHttpService.h"


@implementation CDHttpService


/**
 *  get请求 减少对AFNetworking 的依赖
 *
 *  @param URLString  请求头
 *  @param parameters 请求参数
 *  @param success    请求成功处理block
 *  @param failure    请求失败处理block
 */
+ (void)GET:(NSString *)URLString parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}


/**
 *  post请求 减少对AFNetworking 的依赖
 *
 *  @param URLString  请求头
 *  @param parameters 请求参数
 *  @param success    请求成功处理block
 *  @param failure    请求失败处理block
 */
+ (void)POST:(NSString *)URLString parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}



@end
