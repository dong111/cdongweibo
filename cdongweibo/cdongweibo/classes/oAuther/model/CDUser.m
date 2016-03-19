//
//  CDUser.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/17.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDUser.h"
#import "MJExtension.h"

#define CD_USER_TOKEN_KEY @"token"
#define CD_USER_ID_KEY @"uid"
#define CD_USERE_EXPIRES_IN_KEY @"expires_in"
#define CD_USERE_EXPIRES_DATE_KEY @"expires_date"
/**
 *  KVC底层实现：遍历字典里面的所有key(uid)
 一个一个获取key，会去模型里面查找setKey:setUid,直接调用这个方法，赋值setUid(obj)
 寻找有没有带下划线的_key,_uid，直接赋值
 寻找有没有key的属性,如果有直接赋值
 如果在模型里面找不到对应的key，就会报错   --->待验证  验证通过(这个好恶心)
 */
@implementation CDUser


- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in = expires_in;
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:expires_in.longLongValue];
}

+ (instancetype)userWithDic:(NSDictionary *)dic
{
    CDUser *user = [[self alloc] init];
    
    [user setValuesForKeysWithDictionary:dic];
    
    return user;
}

#pragma mark NScoding 实现对象归档解档方法
MJExtensionCodingImplementation
//归档时候调用  告诉系统哪个属性需要归档  如何归档
//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder encodeObject:_access_token forKey:CD_USER_TOKEN_KEY];
//    [aCoder encodeObject:_uid forKey:CD_USER_ID_KEY];
//    [aCoder encodeObject:_expires_in forKey:CD_USERE_EXPIRES_IN_KEY];
//    [aCoder encodeObject:_expires_date forKey:CD_USERE_EXPIRES_DATE_KEY];
//}
////解档时候调用  告诉系统哪个属性需要解档  如何解档
//- (instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    //解档后一定要记得赋值给属性
//    _access_token = [aDecoder decodeObjectForKey:CD_USER_TOKEN_KEY];
//    _uid = [aDecoder decodeObjectForKey:CD_USER_ID_KEY];
//    _expires_in = [aDecoder decodeObjectForKey:CD_USERE_EXPIRES_IN_KEY];
//    _expires_date = [aDecoder decodeObjectForKey:CD_USERE_EXPIRES_DATE_KEY];
//    return self;
//}



@end
