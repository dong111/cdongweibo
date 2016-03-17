//
//  CDUser.h
//  cdongweibo
//
//  Created by 陈栋 on 16/3/17.
//  Copyright © 2016年 man. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  2016-03-17 10:13:29.606 cdongweibo[5692:1521063] {
 "access_token" = "2.00L1qZWDmrI6ZCac30604eb00HMwN9";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 3229783867;
 }
 
 */
@interface CDUser : NSObject
/**
 *  获取数据访问时候的令牌
 */
@property (nonatomic,copy) NSString *access_token;
/**
 *  access_token的生命周期
 */
@property (nonatomic,copy) NSString *expires_in;
/**
 *  access_token的生命周期 已经废弃
 */
@property (nonatomic,copy) NSString *remind_in;
/**
 *  用户唯一标识符
 */
@property (nonatomic,copy) NSString *uid;

/**
 *  kvc 初始化对象
 *
 *  @param dic kvc 初始化对象
 *
 *  @return 用户实体
 */
+(instancetype) userWithDic:(NSDictionary *)dic;


@end
