//
//  CDComposeToolBar.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/22.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDComposeToolBar.h"
#import "UIView+Frame.h"

@implementation CDComposeToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //添加子控件
        [self setUpAllChildViews];
        
    }
    return self;
}


//添加子控件
- (void) setUpAllChildViews
{
    // 相册
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_toolbar_picture"] highImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] target:self action:@selector(btnClick:)];
    // 提及
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_toolbar_picture"] highImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] target:self action:@selector(btnClick:)];
    // 话题
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_toolbar_picture"] highImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] target:self action:@selector(btnClick:)];
    // 表情
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_toolbar_picture"] highImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] target:self action:@selector(btnClick:)];
    // 键盘]
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_toolbar_picture"] highImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] target:self action:@selector(btnClick:)];
}

- (void) btnClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(composeToolBar:DidClickBtn:)]){
        [self.delegate composeToolBar:self DidClickBtn:button.tag];
    }
}
- (void)setUpButtonWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action
{
    // btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    
    btn.tag = self.subviews.count;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
}


//显示子控件设置
- (void)layoutSubviews
{
    //**注意父类方法
    [super layoutSubviews];
    CGFloat btnW = self.width / self.subviews.count;
    CGFloat btnH = 35;
    CGFloat btny = self.height-btnH;
    int i=0;
    for (UIButton *btn in self.subviews) {
        CGFloat btnX = i*btnW;
        btn.frame = CGRectMake(btnX, btny, btnW, btnH);
        i++;
    }
    

}


@end
