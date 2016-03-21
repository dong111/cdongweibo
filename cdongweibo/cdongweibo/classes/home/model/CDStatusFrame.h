//
//  CDStatusFrame.h
//  cdongweibo
//  status  VM  微博状态视图模型
//  Created by 陈栋 on 16/3/19.
//  Copyright © 2016年 man. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDStatus.h"
#import <UIKit/UIKit.h>

@interface CDStatusFrame : NSObject
/**
 *  微博数据
 */
@property (nonatomic,strong) CDStatus *status;

/**
 *  原创微博frame
 */
@property (nonatomic,assign) CGRect originalViewFrame;

/***********************原创微博子控件*******************************/

// 头像Frame
@property (nonatomic, assign) CGRect originalIconFrame;

// 昵称Frame
@property (nonatomic, assign) CGRect originalNameFrame;

// vipFrame
@property (nonatomic, assign) CGRect originalVipFrame;

// 时间Frame
@property (nonatomic, assign) CGRect originalTimeFrame;

// 来源Frame
@property (nonatomic, assign) CGRect originalSourceFrame;

// 正文Frame
@property (nonatomic, assign) CGRect originalTextFrame;

// 原创图片
@property (nonatomic, assign) CGRect originalPhotosFrame;


/***********************原创微博子控件*******************************/

/**
 *  转发微博frame
 */
@property (nonatomic,assign) CGRect retWeetViewFrame;

/**   ******转发微博子控件frame**** */
// 昵称Frame
@property (nonatomic, assign) CGRect retweetNameFrame;

// 正文Frame
@property (nonatomic, assign) CGRect retweetTextFrame;

// 转发图片
@property (nonatomic, assign) CGRect retweetPhotosFrame;

/**
 *  微博工具栏
 */
@property (nonatomic,assign) CGRect statusBarViewFrame;



/**
 *  cell高度
 */
@property (nonatomic,assign) CGFloat heigth;


@end
