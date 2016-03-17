//
//  CDStatus.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/17.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDStatus.h"
#import "CDWeiboPhoto.h"

@implementation CDStatus
//实现这个方法，就会自动把数组中的字典装换成对应的模型
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"pic_urls":[CDWeiboPhoto class]};
}


@end
