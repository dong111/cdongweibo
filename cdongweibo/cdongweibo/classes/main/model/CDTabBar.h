//
//  CDTabBar.h
//  cdongweibo
//
//  Created by 陈栋 on 16/3/11.
//  Copyright © 2016年 man. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CDTabBar;
@protocol CDTabBarButtonDelegate <NSObject>

@optional
//tabBar点击事件方法
- (void) tabBar:(CDTabBar *)tabBar didClickButton:(NSInteger) index;

@end

@interface CDTabBar : UIView
//保存每个按钮对应的tabBarItem模型
@property (nonatomic,strong) NSMutableArray *items;
@property (nonatomic,strong) id<CDTabBarButtonDelegate> delegate;
@end
