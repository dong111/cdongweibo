//
//  CDNavigationController.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/15.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDNavigationController.h"

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
