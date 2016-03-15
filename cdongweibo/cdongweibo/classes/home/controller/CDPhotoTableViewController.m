//
//  CDPhotoTableViewController.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/15.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDPhotoTableViewController.h"
#import "UIBarButtonItem+BarItem.h"

@interface CDPhotoTableViewController ()

@end

@implementation CDPhotoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBtns];
}
- (void) initNavigationBtns
{
    UIBarButtonItem *leftBtn = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] ighLigtht:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    UIBarButtonItem *rightBtn = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] ighLigtht:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
}
- (void) backClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void) moreClick
{
    
    
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
