//
//  CDNewFeatureCell.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/16.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDNewFeatureCell.h"

@interface CDNewFeatureCell ()
//私有属性做懒加载
@property (nonatomic,weak) UIImageView *imageView;

@property (nonatomic,weak) UIButton *startBtn;

@property (nonatomic,weak) UIButton *shareBtn;
@end

@implementation CDNewFeatureCell

- (UIImageView *)imageView
{
    if (_imageView==nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        _imageView = imageView;
        [self.contentView addSubview:imageView];
    }
    
    return _imageView;
}


- (void)setImage:(UIImage *)image
{
    self.imageView.image = image;
}

//计算子控件frame
- (void)layoutSubviews
{
    self.imageView.frame = self.contentView.frame;
}











@end
