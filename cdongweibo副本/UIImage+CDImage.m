//
//  UIImage+CDImage.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/10.
//  Copyright © 2016年 man. All rights reserved.
//

#import "UIImage+CDImage.h"

@implementation UIImage (CDImage)

+ (instancetype)imageAlwaysOriginalName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return  [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
