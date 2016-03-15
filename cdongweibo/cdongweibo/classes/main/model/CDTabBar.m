//
//  CDTabBar.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/11.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDTabBar.h"
#import "CDTabBarButton.h"

@interface CDTabBar ()

//自定义tabBarItem 为中间button按钮
@property (nonatomic,weak) UIButton *centerBt;

@property (nonatomic, strong) NSMutableArray *buttons;

@end

@implementation CDTabBar


- (UIButton *)centerBt
{
    if (_centerBt==nil) {
        UIButton *button = [[UIButton alloc] init];
        
        [button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        //设置button 大小和内容一样大 方法
        //sizeToFit：默认按照背景图片或者图片和文字自动计算控件大小
        [button sizeToFit];
        
        _centerBt = button;
        [self addSubview:_centerBt];
    }
    return _centerBt;
}

- (NSMutableArray *)buttons{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (void)setItems:(NSMutableArray *)items
{
    _items = items;
    for (UITabBarItem *item in items) {
        CDTabBarButton *button = [CDTabBarButton buttonWithType:UIButtonTypeCustom];
        //按钮内容模型赋值
        button.item = item;
//        [button setBackgroundColor:[UIColor orangeColor]];
        
        [self addSubview:button];
        [self.buttons addObject:button];
    }
}


/**
 *  调整子控件的位置
 */
- (void)layoutSubviews
{
    //测试是否有子控件是否有了
//    NSLog(@"subBiews :%@",self.subviews);
    //获取总tabBar size
    CGFloat barWidth = self.bounds.size.width;
    CGFloat barHeight = self.bounds.size.height;
    CGFloat itemWidth = barWidth/(self.items.count+1);
    
    //设置子控件的距离
    int i=0;
    for (UIView *tabBarBtton in self.buttons) {
            //计算每个button 的frame
            if (i==2) {
                i=3;
            }
            CGFloat itemX = i*itemWidth;
            tabBarBtton.frame = CGRectMake(itemX, 0, itemWidth, barHeight);
            i++;
    }
    //设置中心按钮的位置
    self.centerBt.center = CGPointMake(barWidth/2, barHeight/2);
    self.backgroundColor = [UIColor whiteColor];
    self.alpha = 0.7;
    
}


@end
