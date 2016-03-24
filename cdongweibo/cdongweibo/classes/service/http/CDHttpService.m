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
       failure:(void (^)(NSError *error))failure
{
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //         @param block A block that takes a single argument and appends data to the HTTP body. The block argument is an object adopting the `AFMultipartFormData` protocol.
        [formData appendPartWithFileData:uploadFile.data name:uploadFile.name fileName:uploadFile.fileName mimeType:uploadFile.mimeType];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}



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
       failure:(void (^)(NSError *error))failure
{
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//         @param block A block that takes a single argument and appends data to the HTTP body. The block argument is an object adopting the `AFMultipartFormData` protocol.
        
        if (uploadFiles.count>0) {
            for (NSObject *obj in uploadFiles) {
                if ([obj isKindOfClass:[CDHttpUploadFile class]]) {
                    CDHttpUploadFile *uploadFile = obj;
                [formData appendPartWithFileData:uploadFile.data name:uploadFile.name fileName:uploadFile.fileName mimeType:uploadFile.mimeType];
                }
            }
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}



@end
