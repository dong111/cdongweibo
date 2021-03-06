//
//  CDHttpService.h
//  cdongweibo
//
//定制 http请求协议
//  Created by 陈栋 on 16/3/17.
//  Copyright © 2016年 man. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "CDHttpUploadFile.h"
@interface CDHttpService : NSObject


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
    failure:(void (^)(NSError *error))failure;




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
    failure:(void (^)(NSError *error))failure;




/**
 *  http 上传单个文件
 *
 *  @param URLString   上传路径
 *  @param parameters  请求参数
 *  @param uploadFile 上传单个文件参数
 *  @param success     成功回调
 *  @param failure     失败回调
 */
+ (void)UPLOAD:(NSString *)URLString parameters:(id)parameters
    uploadFile:(CDHttpUploadFile *)uploadFile
       success:(void (^)(id responseObject))success
       failure:(void (^)(NSError *error))failure;




/**
 *  http 上传多个文件
 *
 *  @param URLString   上传路径
 *  @param parameters  请求参数
 *  @param uploadFiles 上传多个文件参数
 *  @param success     成功回调
 *  @param failure     失败回调
 */
+ (void)UPLOAD:(NSString *)URLString parameters:(id)parameters
    uploadFiles:(NSArray *)uploadFiles
       success:(void (^)(id responseObject))success
       failure:(void (^)(NSError *error))failure;

@end
