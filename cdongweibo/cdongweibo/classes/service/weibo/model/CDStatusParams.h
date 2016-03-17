//
//  CDStatusParams.h
//  cdongweibo
//  分装status请求参数
//  Created by 陈栋 on 16/3/18.
//  Copyright © 2016年 man. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CDStatusParams : NSObject
/**
 *  搜全令牌
 */
@property (nonatomic,copy) NSString *access_token;
/**
 *  则返回ID比since_id大的微博
 */
@property (nonatomic,copy) NSString *since_id;
/**
 *   返回ID小于或等于max_id的微博
 */
@property (nonatomic,copy) NSString *max_id;

@end
