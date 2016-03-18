//
//  CDUnReadCountResult.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/18.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDUnReadCountResult.h"

@implementation CDUnReadCountResult



/**
 *  计算消息总和 = 评论数+私信数+提及我的微博数+提及我的评论数
 *
 *  @return 计算消息总和
 */
- (int)messageCount
{
    return _cmt+_dm+_mention_status+_mention_cmt;
}

/**
 *  总消息数 =messageCount+ 新微博数+新粉丝
 *
 *  @return 所有获取的消息
 */
- (int) totalCount
{
    return self.messageCount + _status + _follower;
}

@end
