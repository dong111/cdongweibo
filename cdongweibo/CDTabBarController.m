//
//  CDTabBarController.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/10.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDTabBarController.h"

@implementation CDTabBarController

- (void)loadView
{
    //实现父类
    [super loadView];
    
    //加载自控制器
    [self setUpAllChildViewController];
}


- (void) setUpAllChildViewController
{
    //创建自控制器
    //首页
    UIViewController *home = [[UIViewController alloc] init];
    home.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:home];
    //消息
    UIViewController *message = [[UIViewController alloc] init];
    message.view.backgroundColor = [UIColor blueColor];
    [self addChildViewController:message];
    //发现
    UIViewController *discover = [[UIViewController alloc] init];
    discover.view.backgroundColor = [UIColor purpleColor];
    [self addChildViewController:discover];
    //我
    UIViewController *profile = [[UIViewController alloc] init];
    profile.view.backgroundColor = [UIColor lightGrayColor];
    [self addChildViewController:profile];
}









@end
