//
//  CDNewFeatureCell.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/16.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDNewFeatureCell.h"
#import "CDTabBarController.h"

@interface CDNewFeatureCell ()
//私有属性做懒加载
@property (nonatomic,weak) UIImageView *imageView;

@property (nonatomic,weak) UIButton *startBtn;

@property (nonatomic,weak) UIButton *shareBtn;
@end

@implementation CDNewFeatureCell

- (UIButton *)startBtn
{
    if (_startBtn==nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"开始微博" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [button sizeToFit];
        [button addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchDown];
        _startBtn = button;
        [self addSubview:button];
    }
    
    return _startBtn;
}


- (UIButton *)shareBtn
{
    if (_shareBtn==nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"分享给大家" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [button sizeToFit];
        _shareBtn = button;
        [self addSubview:button];
    }
    return _shareBtn;
}

- (void) startBtnClick
{
    //创建tabbarview为   root view
        CDTabBarController *tabBarVc = [[CDTabBarController alloc] init];
        self.window.rootViewController = tabBarVc;
}

- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count
{
    if (indexPath.row==count-1) {
        self.shareBtn.hidden = NO;
        self.startBtn.hidden = NO;
    }else{
        self.shareBtn.hidden = YES;
        self.startBtn.hidden = YES;
    }
}

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
    [super layoutSubviews];
    CGRect frame = self.contentView.frame;
    self.imageView.frame = frame;
    
    //分享按钮
    self.shareBtn.center = CGPointMake(frame.size.width*0.5, frame.size.height*0.8);
    //开始按钮
    self.startBtn.center = CGPointMake(frame.size.width*0.5, frame.size.height*0.9);
}











@end
