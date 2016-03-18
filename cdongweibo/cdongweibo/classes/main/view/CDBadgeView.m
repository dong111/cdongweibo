//
//  CDBadgeView.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/15.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDBadgeView.h"
#import "NSString+utility.h"
#import "CDUitiity.h"
#define CDBadgeViewFont [UIFont systemFontOfSize:11]

@implementation CDBadgeView


//根据badgeValue值开控制按钮显示和隐藏
- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
//    self.titleLabel.text = _badgeValue;
    [self setTitle:badgeValue forState:UIControlStateNormal];
    self.hidden = [NSString isBlankString:_badgeValue]
                    ||[_badgeValue isEqualToString:@"0"];
    //计算文字图片大小
    CGSize textSize = [badgeValue sizeWithFont:CDBadgeViewFont];
//    CDLog(@"%f---%f",textSize.width,self.width);
    if (textSize.width>self.width) {
        self.width = textSize.width;
    }
}




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
        self.titleLabel.textColor = [UIColor blackColor];
        [self sizeToFit];
    }
    return self;
}





@end
