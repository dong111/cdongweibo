//
//  CDWeiBoUser.h
//  cdongweibo
//
//  Created by 陈栋 on 16/3/17.
//  Copyright © 2016年 man. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDWeiBoUser : NSObject

/**
 *  微博昵称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  微博头像
 */
@property (nonatomic, strong) NSURL *profile_image_url;


@end
