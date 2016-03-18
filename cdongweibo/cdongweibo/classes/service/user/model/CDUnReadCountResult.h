//
//  CDUnReadCountResult.h
//  cdongweibo
//
//  Created by 陈栋 on 16/3/18.
//  Copyright © 2016年 man. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDUnReadCountResult : NSObject

/**
 *  新微博未读数
 */
@property (nonatomic,assign,readonly) int status;
/**
 *  新粉丝数
 */
@property (nonatomic,assign,readonly) int follower;
/**
 *  新评论数
 */
@property (nonatomic,assign,readonly) int cmt;
/**
 *  新私信数
 */
@property (nonatomic,assign,readonly) int dm;


/**
 *  新提及我的微博数
 */
@property (nonatomic, assign) int mention_status;
/**
 *  新提及我的评论数
 */
@property (nonatomic, assign) int mention_cmt;

/**
 *  计算消息总和 = 评论数+私信数+提及我的微博数+提及我的评论数
 *
 *  @return 计算消息总和
 */
- (int)messageCount;

/**
 *  总消息数 =messageCount+ 新微博数+新粉丝
 *
 *  @return 所有获取的消息
 */
- (int) totalCount;




@end
