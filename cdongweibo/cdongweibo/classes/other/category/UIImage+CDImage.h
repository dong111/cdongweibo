//
//  UIImage+CDImage.h
//  cdongweibo
//
//  Created by 陈栋 on 16/3/10.
//  Copyright © 2016年 man. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CDImage)

/**
 *  ios7以后tabbarItem 上的图片默认会渲染成蓝色,提供方法使用图片原始颜色
 *
 *  @param imageName 图片名称
 *
 *  @return 原始颜色图片
 */
+ (instancetype) imageAlwaysOriginalName:(NSString *)imageName;

//创建一个内容可拉伸，而边角不拉伸的图片
+ (instancetype) imageWithStretchableName:(UIImage *) image;

@end
