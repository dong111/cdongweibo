//
//  CDRootService.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/17.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDRootService.h"
#import "CDTabBarController.h"
#import "CDNewFeatureController.h"

#define CDVersionKey @"appVersion"
@implementation CDRootService


+ (void) chooseRootView:(UIWindow *)window
{
    //获取当前版本
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    //2.获取上次版本号，存储在preferces中
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults]stringForKey:CDVersionKey];;
    
    if ([lastVersion isEqualToString:currentVersion]) {
        //不用显示新特效
        //创建tabbarview为   root view
        CDTabBarController *tabBarVc = [[CDTabBarController alloc] init];
        window.rootViewController = tabBarVc;
        //UICollectionView must be initialized with a non-nil layout parameter'
    }else{
        CDNewFeatureController *featureVc = [[CDNewFeatureController alloc] init];
        featureVc.collectionView.backgroundColor = [UIColor whiteColor];
        window.rootViewController = featureVc;
        //存储当前版本信息
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:CDVersionKey];
    }
    
}


@end
