//
//  CDUser.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/17.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDUser.h"
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

@end
