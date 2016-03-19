//
//  CDWeiBoSystemParams.h
//  cdongweibo
//
//  Created by 陈栋 on 16/3/18.
//  Copyright © 2016年 man. All rights reserved.
//

#import <Foundation/Foundation.h>
//获取access_code rul
#define CD_ACCESS_TOKEN_URL @"https://api.weibo.com/oauth2/access_token"
#define CD_AUTHORIZE_URL @"https://api.weibo.com/oauth2/authorize"
//获取未读微博消息接口
#define CD_UNREAD_COUNT_URL @"https://rm.api.weibo.com/2/remind/unread_count.json"
//根据用户ID获取用户信息
#define CD_USERS_URL @"https://api.weibo.com/2/users/show.json"
#define CD_CLIENT_ID @"2355429710"
#define CD_REDIRECT_URL @"http://www.baidu.com"
#define CD_CLIENT_SECRET @"4d9e6693f9fa7cfa3b44a197d9698fd1"
#define CD_GRANT_TYPE @"authorization_code"


@interface CDWeiBoSystemParams : NSObject

@end
