//
//  CDWeiBoTopService.h
//  cdongweibo
//  从新浪微博获取数据的顶级服务类
//  Created by 陈栋 on 16/3/17.
//  Copyright © 2016年 man. All rights reserved.
//

#import <Foundation/Foundation.h>

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


@end
