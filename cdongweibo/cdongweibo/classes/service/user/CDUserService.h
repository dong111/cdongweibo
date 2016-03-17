//
//  CDUserService.h
//  cdongweibo
//  用户信息保存获取服务类
//  Created by 陈栋 on 16/3/17.
//  Copyright © 2016年 man. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDUser.h"

@interface CDUserService : NSObject

+ (void) saveUser:(CDUser *)user;

+ (CDUser *) user;


@end
