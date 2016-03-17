//
//  CDStatus.h
//  cdongweibo
//
//  Created by 陈栋 on 16/3/17.
//  Copyright © 2016年 man. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDWeiBoUser.h"
#import "MJExtension.h"


@interface CDStatus : NSObject<MJKeyValue>


/**
 *  用户
 */
@property (nonatomic, strong) CDWeiBoUser *user;

/**
 *  微博创建时间
 */
@property (nonatomic, copy) NSString *created_at;

/**
 *  字符串型的微博ID
 */
@property (nonatomic, copy) NSString *idstr;

/**
 *  微博信息内容
 */
@property (nonatomic, copy) NSString *text;

/**
 *  微博来源
 */
@property (nonatomic, copy) NSString *source;

/**
 *  转发数
 */
@property (nonatomic, assign) int reposts_count;

/**
 *  评论数
 */
@property (nonatomic, assign) int comments_count;

/**
 *  表态数(赞)
 */
@property (nonatomic, assign) int attitudes_count;

/**
 *  配图数组(CZPhoto)
 */
@property (nonatomic, strong) NSArray *pic_urls;


@end
