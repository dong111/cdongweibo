//
//  CDStatusResult.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/18.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDStatusResult.h"
#import "CDStatus.h"

@implementation CDStatusResult

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"statuses":[CDStatus class]};
}

@end
