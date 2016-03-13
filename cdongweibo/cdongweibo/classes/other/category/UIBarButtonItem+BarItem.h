//
//  UIBarButtonItem+BarItem.h
//  cdongweibo
//
//  Created by 陈栋 on 16/3/13.
//  Copyright © 2016年 man. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BarItem)




//自定义barItem实例方法
+ (instancetype) barButtonItemWithImage:(UIImage *)image ighLigtht:(UIImage *)highImage  target:(id)target action:(SEL)aciton forControlEvents:(UIControlEvents) controlEvent;





//自定义barItem实例方法  这么实现有问题  高亮图片无法设置
+ (instancetype) barButtonItemWithImage:(UIImage *)image highLigtht:(UIImage *)highImage title:(NSString *)title style:(UIBarButtonItemStyle) style target:(id) target action:(SEL) sel;


@end
