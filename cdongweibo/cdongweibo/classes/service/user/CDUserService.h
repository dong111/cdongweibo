//
//  CDUserService.h
//  cdongweibo
//  用户信息保存获取服务类
//  Created by 陈栋 on 16/3/17.
//  Copyright © 2016年 man. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDUser.h"
#import "CDWeiBoSystemParams.h"

@interface CDUserService : NSObject
/**
 *  持久化用户数据
 *
 *  @param user 用户对象
 */
+ (void) saveUser:(CDUser *)user;
/**
 *  持久化层获取用户数据
 *
 *  @return 返回用户数据对象
 */
+ (CDUser *) user;

/**
 *  通过appkey获取用户信息accessCode
 *
 *  @param code    appkey
 *  @param success 成功时候回调
 *  @param failure 失败时候回调
 */
+ (void) accessCodeWithCode:(NSString *)code success:(void(^)()) success failure:(void(^)(NSError *error)) failure;



@end
