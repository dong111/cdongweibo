//
//  CDWeiBoTopService.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/17.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDWeiBoTopService.h"
#import "CDHttpService.h"
#import "CDUserService.h"
#import "CDStatus.h"
#import "NSString+utility.h"
#import "CDStatusResult.h"
#import "CDStatusParams.h"
#import "NSData+CD.h"
#import "NSDate+MJ.h"

#define FRIENDS_TIME_URL @"https://api.weibo.com/2/statuses/friends_timeline.json"

@implementation CDWeiBoTopService

/**
 *  加载新微博数据
 *
 *  @param sinceId   从大于sinceId(微博id)的数据
 *  @param sucess  获取数据成功时候调用block
 *  @param failure 获取数据失败时候调用block
 */
+ (void) weiboGetNewInfosFromSinceId:(NSString *)sinceId sucess:(void(^)(NSArray *statuses))sucess failure:(void(^)(NSError *error)) failure
{
    CDStatusParams *params = [[CDStatusParams alloc] init];
    params.access_token = [CDUserService user].access_token;
    //    since_id	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
    if (![NSString isBlankString:sinceId]) {
        params.since_id= sinceId;
    }
    
    [CDHttpService GET:FRIENDS_TIME_URL parameters:params.mj_keyValues success:^(id responseObject) {
        //请求成功
        CDStatusResult *result = [CDStatusResult mj_objectWithKeyValues:responseObject];
        //        CDLog(@"加载了老数据数量:%ld",weibostatus.count);
        if (sucess) {
            sucess(result.statuses);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


/**
 *  加载旧微博数据
 *
 *  @param maxId   大于等于maxId (微博id)开始的数据
 *  @param sucess  获取数据成功时候调用block
 *  @param failure 获取数据失败时候调用block
 */
+ (void) weiboGetOldInfosFromMaxId:(NSString *)maxId sucess:(void(^)(NSArray *statuses))sucess failure:(void(^)(NSError *error)) failure
{
    CDStatusParams *params = [[CDStatusParams alloc] init];

    params.access_token = [CDUserService user].access_token;
    //    since_id	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
    if (![NSString isBlankString:maxId]) {
        params.max_id= maxId;
    }
    
    [CDHttpService GET:FRIENDS_TIME_URL parameters:params.mj_keyValues success:^(id responseObject) {
        //请求成功
        CDStatusResult *result = [CDStatusResult mj_objectWithKeyValues:responseObject];
        if (sucess) {
            sucess(result.statuses);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}




/**
 *  向微博服务器推动文字信息
 *
 *  @param text   文字内容
 *  @param sucess  推送成功回调
 *  @param failure 推送失败回调
 */
+ (void) weiboSendText:(NSString *)text sucess:(void(^)())sucess failure:(void(^)(NSError *error)) failure
{
    NSString *url = @"https://api.weibo.com/2/statuses/update.json";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = text;
    params[@"access_token"] =[CDUserService user].access_token ;
    [CDHttpService POST:url parameters:params success:^(id responseObject) {
        if (sucess) {
            sucess();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

/**
 *  向微博服务器推动图片文字信息
 *
 *  @param image 图片内容
 *  @param sucess  推送成功回调
 *  @param failure 推送失败回调
 */
+ (void) weiboSendImage:(UIImage *)image text:(NSString *)text sucess:(void(^)())sucess failure:(void(^)(NSError *error)) failure
{
    NSString *url = @"https://upload.api.weibo.com/2/statuses/upload.json";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = text;
    params[@"access_token"] =[CDUserService user].access_token;
    
    NSMutableArray *uploadFiles = [[NSMutableArray alloc] init];

        CDHttpUploadFile *uploadFile = [[CDHttpUploadFile alloc] init];
        //默认采取png获取图片格式
        NSData *fileData = UIImagePNGRepresentation(image);;
        uploadFile.name = @"pic";//参数key名称
        uploadFile.data = fileData;
        uploadFile.mimeType = [NSData mimetypeForImageData:fileData];
        //获取时间戳当文件名
        NSString *timeStamp = [NSDate dateTimeStamp];
        NSString *fileType = [NSData typeNameForImageData:fileData];
        uploadFile.fileName = [NSString stringWithFormat:@"%@.%@",timeStamp,fileType];


        [CDHttpService UPLOAD:url parameters:params uploadFile:uploadFile success:^(id responseObject) {
            if (sucess) {
                sucess();
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    
}



/**
 *  向微博服务器推送多个图片文字信息
 *
 *  @param images 图片数组内容
 *  @param sucess  推送成功回调
 *  @param failure 推送失败回调
 */
+ (void) weiboSendImages:(NSArray *)images text:(NSString *)text sucess:(void(^)())sucess failure:(void(^)(NSError *error)) failure
{
    
    NSString *url = @"https://upload.api.weibo.com/2/statuses/upload.json";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = text;
    params[@"access_token"] =[CDUserService user].access_token;
    
    NSMutableArray *uploadFiles = [[NSMutableArray alloc] init];
    //生成上传文件的格式
    if (images.count>0) {
        for (NSObject *obj in images) {
            if ([obj isKindOfClass:[UIImage class]]) {
                UIImage *image = (UIImage *)obj;
                CDHttpUploadFile *uploadFile = [[CDHttpUploadFile alloc] init];
                //默认采取png获取图片格式
                NSData *fileData = UIImagePNGRepresentation(image);;
                uploadFile.name = @"pic";//参数key名称
                uploadFile.data = fileData;
                uploadFile.mimeType = [NSData mimetypeForImageData:fileData];
                //获取时间戳当文件名
                NSString *timeStamp = [NSDate dateTimeStamp];
                NSString *fileType = [NSData typeNameForImageData:fileData];
                uploadFile.fileName = [NSString stringWithFormat:@"%@.%@",timeStamp,fileType];
                [uploadFiles addObject:uploadFile];
            }
        }
    }

    [CDHttpService UPLOAD:url parameters:params uploadFiles:uploadFiles success:^(id responseObject) {
        if (sucess) {
            sucess();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}




@end
