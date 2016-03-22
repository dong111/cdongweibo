//
//  CDNavigationController.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/15.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDNavigationController.h"
#import "UIBarButtonItem+BarItem.h"
#import "CDUitiity.h"


@interface CDNavigationController ()<UINavigationControllerDelegate>
@property(nonatomic,strong) id <UIGestureRecognizerDelegate> popDelegate;
@end

@implementation CDNavigationController


+(void)initialize
{
    //获取当前控制器下面的UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    //设置导航栏按钮文字颜色
    NSMutableDictionary *attrs = [[NSMutableDictionary alloc] init];
    attrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:attrs forState:UIControlStateHighlighted];
    
    //**导航栏按钮上文字文字属性设置不生效 使用自定义button
//    NSMutableDictionary *titleAttrs = [[NSMutableDictionary alloc] init];
//    titleAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    [item setTitleTextAttributes:titleAttrs forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

//    NSLog(@"%@-->%@",viewController,self.childViewControllers);
    
    if (self.childViewControllers.count) {//不是根控制器
        //左边按钮设置后，滑动返回功能就没有了
        UIBarButtonItem *leftBtn = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] ighLigtht:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = leftBtn;
        
        UIBarButtonItem *rightBtn = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] ighLigtht:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.rightBarButtonItem = rightBtn;
        
    }
    
    
    [super pushViewController:viewController animated:animated];
    
}

- (void) backClick
{
    [self popViewControllerAnimated:YES];
    
}


- (void) moreClick
{
     [self popToRootViewControllerAnimated:YES];

}

//导航控制器跳转完成使用调用
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController==self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = self.popDelegate;
    }else{
        //实现滑动返回功能
        //清空滑动手势代理，就能实现滑动返回功能
        self.interactivePopGestureRecognizer.delegate = nil;
    }

}

//导航控制器将要显示时候调用
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    UITabBarController *tabBarVc = (UITabBarController *) CDKeyWindow.rootViewController;
    //移除系统tabBar按钮
    for (UIView *barBtn in tabBarVc.tabBar.subviews) {
        if ([barBtn isKindOfClass:NSClassFromString(@"UITabBarButton")])
        {
            [barBtn removeFromSuperview];
        }
    }
}


@end
