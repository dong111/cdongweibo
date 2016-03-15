//
//  CDPhotoTableViewController.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/15.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDPhotoTableViewController.h"
#import "CDPhoto2TableViewController.h"


@interface CDPhotoTableViewController ()

@end

@implementation CDPhotoTableViewController
- (IBAction)gotoPhoto2:(id)sender {
    CDPhoto2TableViewController *photoVc = [[CDPhoto2TableViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:photoVc animated:YES];
    //并在push后设置self.hidesBottomBarWhenPushed=NO;
    //这样back回来的时候，tabBar会恢复正常显示。
    self.hidesBottomBarWhenPushed = NO;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBtns];
}
- (void) initNavigationBtns
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
