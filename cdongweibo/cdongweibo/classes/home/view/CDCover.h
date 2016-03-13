//
//  CDCover.h
//  cdongweibo
//

//***自定义蒙层

//  Created by 陈栋 on 16/3/13.
//  Copyright © 2016年 man. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CDCover;

@protocol CDCoverDelegate <NSObject>

@optional
//点击蒙层时候调用
- (void)coverDidClick:(CDCover *)cover;

@end
@interface CDCover : UIView

/**
 *  显示蒙层
 *
 *  @return 返回蒙层
 */
+ (instancetype) show;

//设置背景颜色
@property (nonatomic,assign) BOOL dimBackground;

@property (nonatomic,weak) id<CDCoverDelegate> delegate;

@end
