//
//  CDTabBarButton.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/15.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDTabBarButton.h"
#import "CDBadgeView.h"
#import "CDUitiity.h"

#define CDBarImageRadio 0.7
@interface CDTabBarButton ()

@property (nonatomic,weak) CDBadgeView *badgeView;

@end

@implementation CDTabBarButton

//懒加载
- (CDBadgeView *)badgeView
{
    if (_badgeView==nil) {
        CDBadgeView *btn  = [CDBadgeView buttonWithType:UIButtonTypeCustom];
        //加入view
        [self addSubview:btn];
          _badgeView =btn;
    }
    return _badgeView;
}

//设置TabBarItem数据模型
- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    //这里需要手动调用一次observeValueForKeyPath方法为button赋值
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
    //KVO:时刻监听一个对象有没有变化
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
}
//只要监听item模型一有新值就会发生改变
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.image forState:UIControlStateSelected];
    
    self.badgeView.badgeValue = self.item.badgeValue;
}


//修改按钮内部子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize btnSize = self.bounds.size;
    


    //image
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = btnSize.width;
    CGFloat imageH = btnSize.height * CDBarImageRadio;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    //title
    CGFloat titleW = btnSize.width;
    CGFloat titleH = 10;
    CGFloat titleX = 0;
    CGFloat titley = imageH;
    self.titleLabel.frame = CGRectMake(titleX, titley, titleW, titleH);
    self.titleLabel.font = [UIFont systemFontOfSize:11];
    
    //badgeView
    self.badgeView.x = self.width/2+5;
    self.badgeView.y = 0;
}


//按钮初始化时候的设置
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置字体颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        // 图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        //文字字体
    }
    return self;
}

@end
