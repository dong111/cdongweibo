//
//  CDStatusBar.m
//  cdongweibo
//  微博内容状态bar
//  Created by 陈栋 on 16/3/19.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDStatusBarView.h"

@interface CDStatusBarView ()

@end


@implementation CDStatusBarView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //添加所有子控件
        [self setUpAllChildView];
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void) setUpAllChildView
{
    
}




- (void)setStatusFrame:(CDStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 设置frame
    [self setUpFrame];
    // 设置data
    [self setUpData];
}

/**
 *  设置frame
 */
- (void) setUpFrame
{
    
    
}
/**
 *  设置data
 */
- (void) setUpData
{
    
}

@end
