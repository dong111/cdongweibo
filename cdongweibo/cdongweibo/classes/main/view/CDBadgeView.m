//
//  CDBadgeView.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/15.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDBadgeView.h"

#define CDBadgeViewFont [UIFont systemFontOfSize:11]

@implementation CDBadgeView








//初始化CDBadgeView 设置
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //取消按钮所有时间
        self.userInteractionEnabled = NO;
        //设置背景颜色
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        //设置字体大小
        self.titleLabel.font = CDBadgeViewFont;
        
        [self sizeToFit];
    }
    return self;
}





@end
