//
//  CDPopMenu.h
//  cdongweibo
//
//  Created by 陈栋 on 16/3/13.
//  Copyright © 2016年 man. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDPopMenu : UIImageView

//显示菜单
+ (instancetype) showInRect:(CGRect)rect;
//隐藏菜单
+ (void) hide;
//内容视图
@property (nonatomic,weak) UIView *contentView;

@end
