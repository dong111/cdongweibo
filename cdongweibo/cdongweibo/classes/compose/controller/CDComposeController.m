//
//  CDComposeController.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/22.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDComposeController.h"

@interface CDComposeController ()

@end

@implementation CDComposeController

- (void)viewDidLoad {
    [super viewDidLoad];
    //*** 一定要设置 否知view是透明的
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpNavigation];
    
}


- (void) setUpNavigation
{
    //设置title 返回按钮
    self.navigationItem.title = @"发微博";
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancleBtn)];
    
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(writeWeibo) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    UIBarButtonItem *rigthBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];

    
    rigthBtn.enabled = NO;
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.navigationItem.rightBarButtonItem = rigthBtn;
}

- (void) cancleBtn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) writeWeibo
{
    
}


@end
