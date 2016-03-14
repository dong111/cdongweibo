//
//  CDPopMenu.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/13.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDPopMenu.h"
#import "UIImage+CDImage.h"
@implementation CDPopMenu


-(void)layoutSubviews
{
    [super layoutSubviews];
    //设置内容视图尺寸
    if (_contentView!=nil) {
        //获取自己的frame
        CGRect selfRect = self.frame;
        CGFloat contextX = 0;
        CGFloat contextY = 0;
        CGFloat contextW = selfRect.size.width;
        CGFloat contextH = selfRect.size.height;
        _contentView.frame = CGRectMake(contextX, contextY, contextW, contextH);
    }
}


//设置内容视图
-(void)setContentView:(UIView *)contentView
{
    //移除之前的内容视图
    [_contentView removeFromSuperview];
    _contentView = contentView;
    contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:contentView];
}


//显示菜单
+ (instancetype)showInRect:(CGRect)rect
{
    CDPopMenu *menu = [[CDPopMenu alloc]initWithFrame:rect];
    menu.userInteractionEnabled = YES;
    menu.image = [UIImage imageWithStretchableName:[UIImage imageNamed:@"popover_background"]];
    [CDKeyWindow addSubview:menu];
    return menu;
}

//隐藏菜单
+(void)hide
{
    for (UIView *popMenu in CDKeyWindow.subviews) {
        if ([popMenu isKindOfClass:self]) {
            [popMenu removeFromSuperview];
        }
    }
}

@end
