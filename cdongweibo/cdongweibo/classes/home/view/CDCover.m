//
//  CDCover.m
//  cdongweibo
//
//***自定义蒙层

//  Created by 陈栋 on 16/3/13.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDCover.h"
#import "CDUitiity.h"

@implementation CDCover

//设置浅灰色蒙层
- (void)setDimBackground:(BOOL)dimBackground
{
    _dimBackground = dimBackground;
    if (dimBackground) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5;
    }else{
        self.alpha = 1;
        self.backgroundColor = [UIColor clearColor];
    }
}

//显示蒙层
+ (instancetype)show
{
    //生成屏幕大小view
    CDCover *cover = [[CDCover alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //清空背景颜色
    cover.backgroundColor = [UIColor clearColor];

    [CDKeyWindow addSubview:cover];
    
    return cover;
}

//定义点击蒙层时候做的事情
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //移除蒙层
    [self removeFromSuperview];
    //通知代理移除菜单
    if ([_delegate respondsToSelector:@selector(coverDidClick:)]) {
        [_delegate coverDidClick:self];
    }
}

@end
