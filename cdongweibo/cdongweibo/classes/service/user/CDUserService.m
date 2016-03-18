//
//  CDUserService.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/17.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDUserService.h"
#import "CDHttpService.h"


#define CD_USER_ARCHIVE_FILE [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"user.data"]


@implementation CDUserService


+(void)accessCodeWithCode:(NSString *)code success:(void (^)())success failure:(void (^)(NSError *error))failure
{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = CD_CLIENT_ID;
    params[@"client_secret"] = CD_CLIENT_SECRET;
    params[@"grant_type"] = CD_GRANT_TYPE;
    params[@"code"] = code;
    params[@"redirect_uri"] = CD_GRANT_TYPE;
    
    
    [CDHttpService POST:CD_ACCESS_TOKEN_URL parameters:params success:^(id responseObject) {
        CDUser *user = [CDUser userWithDic:responseObject];
        //归档设置
        [CDUserService saveUser:user];
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

//类方法一般使用静态变量代替成员属性
static CDUser *_user;
+ (void)saveUser:(CDUser *)user
{
    [self saveUserByArchive:user];
}

+ (CDUser *)user
{
    return [self userByUnArchive];
}

//保存用户信息到归档文件
+ (void)saveUserByArchive:(CDUser *)user
{
    [NSKeyedArchiver archiveRootObject:user toFile:CD_USER_ARCHIVE_FILE];
}

//从归档文件中获取用户信息
//类方法使用懒加载
+ (CDUser *)userByUnArchive
{
    if (_user== nil) {
        _user =[NSKeyedUnarchiver unarchiveObjectWithFile:CD_USER_ARCHIVE_FILE];
        //用户信息是否过期 如果过期直接放回nil 否则放回获取用户信息
        
        if ([[NSDate date] compare:_user.expires_date] ==NSOrderedDescending) {
            return nil;
        }
    }
    return _user;
}

@end
