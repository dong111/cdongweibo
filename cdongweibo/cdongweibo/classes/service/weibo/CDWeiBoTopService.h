//
//  CDWeiBoTopService.h
//  cdongweibo
//  从新浪微博获取数据的顶级服务类
//  Created by 陈栋 on 16/3/17.
//  Copyright © 2016年 man. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CDWeiBoTopService : NSObject


/**
 *  加载新微博数据
 *
 *  @param sinceId   从大于sinceId(微博id)的数据
 *  @param sucess  获取数据成功时候调用block
 *  @param failure 获取数据失败时候调用block
 */
+ (void) weiboGetNewInfosFromSinceId:(NSString *)sinceId sucess:(void(^)(NSArray *statuses))sucess failure:(void(^)(NSError *error)) failure;


/**
 *  加载旧微博数据
 *
 *  @param maxId   大于等于maxId (微博id)开始的数据
 *  @param sucess  获取数据成功时候调用block
 *  @param failure 获取数据失败时候调用block
 */
+ (void) weiboGetOldInfosFromMaxId:(NSString *)maxId sucess:(void(^)(NSArray *statuses))sucess failure:(void(^)(NSError *error)) failure;

/**
 *  向微博服务器推动文字信息
 *
 *  @param text   文字内容
 *  @param sucess  推送成功回调
 *  @param failure 推送失败回调
 */
+ (void) weiboSendText:(NSString *)text sucess:(void(^)())sucess failure:(void(^)(NSError *error)) failure;

/**
 *  向微博服务器推送单个图片文字信息
 *
 *  @param image 图片内容
 *  @param sucess  推送成功回调
 *  @param failure 推送失败回调
 */
+ (void) weiboSendImage:(UIImage *)image text:(NSString *)text sucess:(void(^)())sucess failure:(void(^)(NSError *error)) failure;


/**
 *  向微博服务器推送多个图片文字信息
 *
 *  @param images 图片数组内容
 *  @param sucess  推送成功回调
 *  @param failure 推送失败回调
 */
+ (void) weiboSendImages:(NSArray *)images text:(NSString *)text sucess:(void(^)())sucess failure:(void(^)(NSError *error)) failure;

@end
