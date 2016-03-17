//
//  UIViewController+HUD.h
//  cdongweibo
//
//  Created by 陈栋 on 16/3/16.
//  Copyright © 2016年 man. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (HUD)


//显示加载
-(void)showHudInView:(UIView *)view;

//加载是否遮盖
-(void)showHudInView:(UIView *)view andMask:(BOOL) isMask;

//显示提示语
-(void)showHudInView:(UIView *)view hint:(NSString *)hint;

//显示提示语是否遮盖
-(void)showHudInView:(UIView *)view hint:(NSString *)hint andMask:(BOOL) isMask;


//成功后提示
-(void)showSuccessWithHint:(NSString*)hint andView:(UIView *)view success:(void (^)(void))success;

//失败后提示
-(void)showErrorWithHint:(NSString *)hint andView:(UIView *)view;

//隐藏
-(void)hideHud;


@end
