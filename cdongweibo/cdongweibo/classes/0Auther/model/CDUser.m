//
//  CDUser.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/17.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDUser.h"

#define CDUserToken @"token"
#define CDUserId @"uid"
#define CDUserExpires @"expires"

/**
 *  KVC底层实现：遍历字典里面的所有key(uid)
 一个一个获取key，会去模型里面查找setKey:setUid,直接调用这个方法，赋值setUid(obj)
 寻找有没有带下划线的_key,_uid，直接赋值
 寻找有没有key的属性,如果有直接赋值
 如果在模型里面找不到对应的key，就会报错   --->待验证  验证通过(这个好恶心)
 */
@implementation CDUser

+ (instancetype)userWithDic:(NSDictionary *)dic
{
    CDUser *user = [[self alloc] init];
    
    [user setValuesForKeysWithDictionary:dic];
    
    return user;
}

#pragma mark NScoding 实现对象归档解档方法
//归档时候调用  告诉系统哪个属性需要归档  如何归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_access_token forKey:CDUserToken];
    [aCoder encodeObject:_uid forKey:CDUserId];
    [aCoder encodeObject:_expires_in forKey:CDUserExpires];
}
//解档时候调用  告诉系统哪个属性需要解档  如何解档
- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    //解档后一定要记得赋值给属性
    _access_token = [aDecoder decodeObjectForKey:CDUserToken];
    _uid = [aDecoder decodeObjectForKey:CDUserId];
    _expires_in = [aDecoder decodeObjectForKey:CDUserExpires];
    return self;
}


@end
