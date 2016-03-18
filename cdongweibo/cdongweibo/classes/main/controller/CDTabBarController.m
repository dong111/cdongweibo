//
//  CDTabBarController.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/10.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDTabBarController.h"
#import "CDUitiity.h"
#import "CDTabBar.h"
#import "CDHomeController.h"
#import "CDMessageController.h"
#import "CDProfileController.h"
#import "CDDiscoverController.h"
#import "CDNavigationController.h"
#import "CDUserService.h"

@interface CDTabBarController ()<CDTabBarButtonDelegate>


@property (nonatomic,strong) NSMutableArray *barItems;

@property (nonatomic,weak) CDHomeController *homeVc ;
@property (nonatomic,weak) CDMessageController *messageVc ;
@property (nonatomic,weak) CDDiscoverController *discoverVc ;
@property (nonatomic,weak) CDProfileController *profileVc ;

@end

@implementation CDTabBarController

- (NSMutableArray *)barItems
{
    if (_barItems==nil) {
        _barItems = [[NSMutableArray alloc] init];
    }
    return _barItems;
}
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
    

    [self setUpTabBar];
#warning 这个地方使用的是主进程
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(unreadCountGet) userInfo:nil repeats:YES];
    
//    [NSTimer timerWithTimeInterval:2 target:self selector:@selector(unreadCountGet) userInfo:nil repeats:YES];

}

#pragma mark  获取用户消息数badge
- (void) unreadCountGet
{
//    NSLog(@"%@",[NSThread currentThread]);
    [CDUserService unreadCountWithSuccess:^(CDUnReadCountResult *result) {
        //设置微博未读数
        self.homeVc.tabBarItem.badgeValue =[NSString stringWithFormat:@"%d", result.status];
        //设置消息未读数
        self.messageVc.tabBarItem.badgeValue =[NSString stringWithFormat:@"%d", result.messageCount];
        //我的粉丝
        self.profileVc.tabBarItem.badgeValue =[NSString stringWithFormat:@"%d", result.follower];
        //设置应用程序所有未读取消息数组
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


#pragma -mark切换控制器
- (void)tabBar:(CDTabBar *)tabBar didClickButton:(NSInteger)index
{
    self.selectedIndex = index;
}

#pragma -mark 自定义tableBar
- (void) setUpTabBar
{

    //自定义tabBar 替换系统自带tabBar
    CDTabBar *tabBar = [[CDTabBar alloc]initWithFrame:self.tabBar.bounds];
    //**如果属性是readonly 又想复制使用kvc
    //    self.tabBar = tabBar;
//    [self setValue:tabBar forKey:@"tabBar"];
//    tabBar.backgroundColor = [UIColor orangeColor];
    tabBar.delegate = self;
    tabBar.items = self.barItems;
//    [self setValue:tabBar forKey:@"tabBar"];  tabBar kvc 无法赋值
    [self.tabBar addSubview:tabBar];
//    [self.tabBar removeFromSuperview];
    //***补充  kvc 底层代码 //    objc_msgSend(self, @selector(setTabBar:),tabBar);
    //    NSLog(@"现在tabBar %@",self.tabBar);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //查看子控件是否在view里面了
//     NSLog(@"%@",self.tabBar.subviews);
    
    //移除系统tabBar按钮
    for (UIView *barBtn in self.tabBar.subviews) {
        if ([barBtn isKindOfClass:NSClassFromString(@"UITabBarButton")])
        {
            [barBtn removeFromSuperview];
        }
    }
}


- (void) setUpAllChildViewController
{
    //创建自控制器
    //首页
    CDHomeController *home = [[CDHomeController alloc] init];
    [self setUpOneChildViewController:home image:[UIImage imageAlwaysOriginalName:@"tabbar_home"] selectedImage:[UIImage imageAlwaysOriginalName:@"tabbar_home_selected"] title:@"首页"];
    _homeVc = home;
//    home.view.backgroundColor = [UIColor redColor];
    //消息
    CDMessageController *message = [[CDMessageController alloc] init];
    [self setUpOneChildViewController:message image:[UIImage imageAlwaysOriginalName:@"tabbar_message_center"] selectedImage:[UIImage imageAlwaysOriginalName:@"tabbar_message_center_selected"] title:@"消息"];
//    message.view.backgroundColor = [UIColor blueColor];
    _messageVc = message;
    //发现
    CDDiscoverController *discover = [[CDDiscoverController alloc] init];
    [self setUpOneChildViewController:discover image:[UIImage imageAlwaysOriginalName:@"tabbar_discover"] selectedImage:[UIImage imageAlwaysOriginalName:@"tabbar_discover_selected"] title:@"发现"];
     _discoverVc = discover;
//    discover.view.backgroundColor = [UIColor purpleColor];

    //我
    CDProfileController *profile = [[CDProfileController alloc] init];
    [self setUpOneChildViewController:profile image:[UIImage imageAlwaysOriginalName:@"tabbar_profile"] selectedImage:[UIImage imageAlwaysOriginalName:@"tabbar_profile_selected"] title:@"我"];
     _profileVc = profile;
//    profile.view.backgroundColor = [UIColor lightGrayColor];

}

#pragma -mark 添加单个子控件方法
- (void) setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *) selectedImage title:(NSString *)title
{
    vc.tabBarItem.title = title;
    //ios7以后tabbarItem 上的图片默认会渲染成蓝色
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    
    [self.barItems addObject:vc.tabBarItem];
    //设置子控件的rootView 为 NavigationController
    CDNavigationController *nav = [[CDNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
}








@end
