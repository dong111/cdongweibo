//
//  CDTitleButton.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/13.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDTitleButton.h"
#import "UIView+Frame.h"
#import "UIImage+CDImage.h"

@implementation CDTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    CDLog(@"%s",__func__);
    if (self=[super initWithFrame:frame]) {
        //设置titleView字体颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self setBackgroundImage:[UIImage imageWithStretchableName:[UIImage imageNamed:@"navigationbar_filter_background_highlighted"]] forState:UIControlStateNormal];
    }
    return self;
}

- (void)layoutSubviews
{
     CDLog(@"%s",__func__);
    [super layoutSubviews];
    
    if (self.imageView==nil || self.titleLabel==nil) return;
    //title
    self.titleLabel.x  = self.imageView.x;
    
    //image
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
}
//重写set方法 扩展计算尺寸功能
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
     CDLog(@"%s",__func__);
    [super setTitle:title forState:state];
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
     CDLog(@"%s",__func__);
    [super setImage:image forState:state];
    [self sizeToFit];
}


@end
