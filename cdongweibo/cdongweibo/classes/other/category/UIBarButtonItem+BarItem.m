//
//  UIBarButtonItem+BarItem.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/13.
//  Copyright © 2016年 man. All rights reserved.
//

#import "UIBarButtonItem+BarItem.h"
#import "NSString+utility.h"

@implementation UIBarButtonItem (BarItem)




+ (instancetype)barButtonItemWithImage:(UIImage *)image ighLigtht:(UIImage *)highImage
target:(id)target action:(SEL)aciton forControlEvents:(UIControlEvents) controlEvent
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置图片和高亮图片
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    
    //按钮大小设置
    
    [btn sizeToFit];
    
    //添加事件
    [btn addTarget:target action:aciton forControlEvents:controlEvent];
    
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}





+ (instancetype)barButtonItemWithImage:(UIImage *)image highLigtht:(UIImage *)highImage title:(NSString *)title style:(UIBarButtonItemStyle) style target:(id) target action:(SEL) sel
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:style target:target action:sel];
    
    [item setBackgroundImage:highImage forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    if (![NSString isBlankString:title]) {
        [item setTitle:title];
    }
    
    return item;
}

@end
