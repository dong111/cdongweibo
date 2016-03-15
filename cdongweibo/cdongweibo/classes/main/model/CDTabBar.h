//
//  CDTabBar.h
//  cdongweibo
//
//  Created by 陈栋 on 16/3/11.
//  Copyright © 2016年 man. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDTabBar : UIView
//保存每个按钮对应的tabBarItem模型
@property (nonatomic,strong) NSMutableArray *items;

@end
