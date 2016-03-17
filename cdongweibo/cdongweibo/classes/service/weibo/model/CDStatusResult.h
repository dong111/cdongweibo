//
//  CDStatusResult.h
//  cdongweibo
//
//  Created by 陈栋 on 16/3/18.
//  Copyright © 2016年 man. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface CDStatusResult : NSObject<MJKeyValue>

/**
 *  用户的微博数组（CZStatus）
 */
@property (nonatomic,strong) NSArray *statuses;

/**
 *  用户最近微博数量
 */
@property (nonatomic,assign,readonly) int total_number;


@end
