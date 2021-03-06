//
//  CDTabBarController.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/10.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDTabBarController.h"
#import "UIImage+CDImage.h"
#import "CDTabBar.h"

@implementation CDTabBarController

/**
 *  
 什么时候调用:程序已启动把所有类加入内存  在执行Main方法之前
 作用:加载类的时候调用
 */
+ (void)load
{

}
/**
 *  什么时候调用:当第一次使用这个类或者子类是的时候调用
 作用:类初始化时候调用  可以做些全局的设置
 
 */
+ (void)initialize
{
    //获取所有的tabBarItem
//    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    //获取当前这个类下面的所有tabBarItem
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *attrs = [[NSMutableDictionary alloc] init];
    attrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [tabBarItem setTitleTextAttributes:attrs forState:UIControlStateSelected];
}

- (void)loadView
{
    //实现父类
    [super loadView];
    
    //加载自控制器
    [self setUpAllChildViewController];
    
    //自定义tabBar 替换系统自带tabBar
    CDTabBar *tabBar = [[CDTabBar alloc]initWithFrame:self.tabBar.frame];
    //**如果属性是readonly 又想复制使用kvc
//    self.tabBar = tabBar;
    [self setValue:tabBar forKey:@"tabBar"];
    //***补充  kvc 底层代码 //    objc_msgSend(self, @selector(setTabBar:),tabBar);
//    NSLog(@"现在tabBar %@",self.tabBar);
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //查看子控件是否在view里面了
//     NSLog(@"%@",self.tabBar.subviews);
}


- (void) setUpAllChildViewController
{
    //创建自控制器
    //首页
    UIViewController *home = [[UIViewController alloc] init];
    [self setUpOneChildViewController:home image:[UIImage imageAlwaysOriginalName:@"tabbar_home"] selectedImage:[UIImage imageAlwaysOriginalName:@"tabbar_home_selected"] title:@"首页"];
    home.view.backgroundColor = [UIColor redColor];
    //消息
    UIViewController *message = [[UIViewController alloc] init];
    [self setUpOneChildViewController:message image:[UIImage imageAlwaysOriginalName:@"tabbar_message_center"] selectedImage:[UIImage imageAlwaysOriginalName:@"tabbar_message_center_selected"] title:@"消息"];
    message.view.backgroundColor = [UIColor blueColor];

    //发现
    UIViewController *discover = [[UIViewController alloc] init];
    [self setUpOneChildViewController:discover image:[UIImage imageAlwaysOriginalName:@"tabbar_discover"] selectedImage:[UIImage imageAlwaysOriginalName:@"tabbar_discover_selected"] title:@"发现"];
    discover.view.backgroundColor = [UIColor purpleColor];

    //我
    UIViewController *profile = [[UIViewController alloc] init];
    [self setUpOneChildViewController:profile image:[UIImage imageAlwaysOriginalName:@"tabbar_profile"] selectedImage:[UIImage imageAlwaysOriginalName:@"tabbar_profile_selected"] title:@"我"];
    profile.view.backgroundColor = [UIColor lightGrayColor];

}

#pragma -mark 添加单个子控件方法
- (void) setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *) selectedImage title:(NSString *)title
{
    vc.view.backgroundColor = [UIColor redColor];
    vc.tabBarItem.title = title;
    //ios7以后tabbarItem 上的图片默认会渲染成蓝色
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    [self addChildViewController:vc];
}








@end
