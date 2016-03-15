//
//  CDTabBarButton.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/15.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDTabBarButton.h"
#import "CDBadgeView.h"

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
    //设置按钮nomar图片 和selectEd 下图
//    [self addObserver:self forKeyPath:nil options:nil context:nil];
    
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






//按钮初始化时候的设置
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置字体颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        //图片居中
        
        //文字居中
        //文字字体
    }
    return self;
}

@end
