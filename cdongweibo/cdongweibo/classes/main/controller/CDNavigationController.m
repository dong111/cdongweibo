//
//  CDNavigationController.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/15.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDNavigationController.h"
#import "UIBarButtonItem+BarItem.h"

@interface CDNavigationController ()

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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

//    NSLog(@"%@-->%@",viewController,self.childViewControllers);
    
    if (self.childViewControllers.count) {//不是根控制器
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
    
    
}


@end
