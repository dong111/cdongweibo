//
//  UIViewController+HUD.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/16.
//  Copyright © 2016年 man. All rights reserved.
//

#import "UIViewController+HUD.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

static const void *objHUDKey = &objHUDKey;
#define SHOW_TIME 1.5

@implementation UIViewController (HUD)

- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, objHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, objHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//显示加载
-(void)showHudInView:(UIView *)view{
    [self showHudInView:view andMask:NO];
}

//加载是否遮盖
-(void)showHudInView:(UIView *)view andMask:(BOOL) isMask{
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hud = [self HUD];
    if (!hud) {
        hud = [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:hud];
    }
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.dimBackground = isMask;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    [self setHUD:hud];
}


//自定义view显示
-(void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view completionBlock:(void (^)(void))completion{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [self HUD];
    if (!hud) {
        hud = [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:hud];
    }
    hud.labelText = text;
    
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    // 1.5秒之后再消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, SHOW_TIME*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [hud hide:YES];
        [self setHUD:nil];
        if (completion) {
            completion();
        }
    });
    
}

//显示提示语
-(void)showHudInView:(UIView *)view hint:(NSString *)hint{
    [self showHudInView:view hint:hint andMask:NO];
}

//显示提示语是否遮盖
-(void)showHudInView:(UIView *)view hint:(NSString *)hint andMask:(BOOL) isMask{
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hud = [self HUD];
    if (!hud) {
        hud = [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:hud];
    }
    
    hud.detailsLabelFont = [UIFont systemFontOfSize:16.0];
    hud.detailsLabelText = hint;
    hud.mode = MBProgressHUDModeText;
    hud.dimBackground = isMask;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    [self setHUD:nil];
    [hud hide:YES afterDelay:SHOW_TIME];
    
}


//成功后提示
-(void)showSuccessWithHint:(NSString*)hint andView:(UIView *)view success:(void (^)(void))success{
    [self show:hint icon:@"success.png" view:view completionBlock:success];
}


//失败后提示
-(void)showErrorWithHint:(NSString *)hint andView:(UIView *)view{
    [self show:hint icon:@"error.png" view:view completionBlock:nil];
}

//隐藏
-(void)hideHud{
    MBProgressHUD *hud = [self HUD];
    if (!hud) {
        return;
    }
    [hud hide:YES];
    [self setHUD:nil];
}


@end
