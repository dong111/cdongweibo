//
//  UIView+Frame.h
//  cdongweibo
//
//  Created by 陈栋 on 16/3/13.
//  Copyright © 2016年 man. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

//分类不能添加成员属性
//@property 在分类里面只会生成setter,getter的声明,不会生成属性和方法的实现
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@end
