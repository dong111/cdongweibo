//
//  CDImagesView.h
//  cdongweibo
//  在发送微博内容区展示需要发送的多张图片视图
//  Created by 陈栋 on 16/3/23.
//  Copyright © 2016年 man. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDImagesView : UIView
//图片展示宽度
@property (nonatomic,assign) CGFloat imageW;
//图片展示高度
@property (nonatomic,assign) CGFloat imageH;

//图片间距
@property (nonatomic,assign) CGFloat margin;

//图片展示多少列
@property (nonatomic,assign) int cols;

//添加图片
- (void) addImage:(UIImage *)image;

@end
