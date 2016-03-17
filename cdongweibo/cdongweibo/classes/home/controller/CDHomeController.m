//
//  CDHomeController.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/11.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDHomeController.h"
#import "UIBarButtonItem+BarItem.h"
#import "CDTitleButton.h"
#import "CDCover.h"
#import "CDPopMenu.h"
#import "CDPopMenuTableController.h"
#import "CDPhotoTableViewController.h"
#import "CDUitiity.h"
#import "CDStatus.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "CDWeiBoTopService.h"


@interface CDHomeController () <CDCoverDelegate>
@property (nonatomic,weak) CDTitleButton *titleBtn;
//分类菜单table
@property (nonatomic,strong) CDPopMenuTableController *popMenuTable;

@property (nonatomic,strong) NSMutableArray *weiboStatuses;
@end

@implementation CDHomeController

- (NSMutableArray *)weiboStatuses
{
    if (_weiboStatuses==nil) {
        _weiboStatuses = [NSMutableArray array];
    }
    return _weiboStatuses;
}

- (CDPopMenuTableController *)popMenuTable
{
    if (_popMenuTable==nil) {
        _popMenuTable = [[CDPopMenuTableController alloc]init];
    }
    return _popMenuTable;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏设置
    [self setUpNavigation];
    
    [self weiboGetNewInfos];
    
//    [NSThread sleepForTimeInterval:200];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(weiboGetNewInfos)];
    
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(weiboGetOldInfos)];
    
}




#pragma mark 获取旧微博数据
- (void) weiboGetOldInfos
{
    NSString *maxId = nil;
    if (self.weiboStatuses.count>0) {
        CDStatus *lastStatus = [self.weiboStatuses lastObject];
        long long  maxIdLong = lastStatus.idstr.longLongValue -1;
        maxId = [NSString stringWithFormat:@"%lld",maxIdLong];
    }
    
    [CDWeiBoTopService weiboGetOldInfosFromMaxId:maxId sucess:^(NSArray *statuses) {
        CDLog(@"加载了老数据数量:%ld",statuses.count);
        [self.weiboStatuses addObjectsFromArray:statuses];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        //请求失败
        NSLog(@"%@",error);
        [self.tableView.mj_footer endRefreshing];
    }];
    
}
#pragma mark 获取最新微博数据
- (void) weiboGetNewInfos
{
//    since_id	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
    NSString *sinceId = nil;
    if (self.weiboStatuses.count>0) {
        CDStatus *preStatus = self.weiboStatuses[0];
        sinceId = preStatus.idstr;
    }
    
    [CDWeiBoTopService weiboGetNewInfosFromSinceId:sinceId sucess:^(NSArray *statuses) {
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0,statuses.count)];
        [self.weiboStatuses insertObjects:statuses atIndexes:indexSet];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        //请求失败
        NSLog(@"%@",error);
        [self.tableView.mj_header endRefreshing];
    }];
    
    
}


#pragma -mark设置导航栏
- (void) setUpNavigation
{
    //左边按钮
    UIBarButtonItem *friendSearchItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] ighLigtht:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendSearchAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:(friendSearchItem) animated:YES];

    //右边按钮
    UIBarButtonItem *popItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] ighLigtht:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = popItem;
    
    
    //titleView 设置
    //title按钮设置
    CDTitleButton *titleBtn = [CDTitleButton buttonWithType:UIButtonTypeCustom];
    _titleBtn = titleBtn;
    [titleBtn setTitle:@"首页" forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];

    // 高亮的时候不需要调整图片
    titleBtn.adjustsImageWhenHighlighted = NO;
    
    [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleBtn;
    //添加弹出蒙层
    
    
}

//点击标题按钮
- (void) titleBtnClick:(UIButton *)button
{
    button.selected = !button.selected;
    CDCover *cover = [CDCover show];
    cover.delegate = self;
//    [cover setDimBackground:YES];
    //弹窗自定义菜单
    CGFloat popW = 200;
    CGFloat popH = popW;
    CGFloat popX = (self.view.width -200) *0.5;
    CGFloat popy = 55;
    CDPopMenu *menu =[CDPopMenu showInRect:CGRectMake(popX, popy, popW, popH)];
//    menu.backgroundColor = [UIColor blackColor];
    menu.contentView = self.popMenuTable.tableView;
    
}
//点击蒙层事件
- (void)coverDidClick:(CDCover *)cover
{
    //移除菜单
    [CDPopMenu hide];
    //按钮选中状态改变
    self.titleBtn.selected = NO;
}

//寻找联系人事件
- (void) friendSearchAction
{
    NSLog(@"friendSearch %s",__func__);
}
- (void) popAction
{
    CDPhotoTableViewController *photoVc = [[CDPhotoTableViewController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:photoVc animated:YES];
    //并在push后设置self.hidesBottomBarWhenPushed=NO;
    //这样back回来的时候，tabBar会恢复正常显示。
         self.hidesBottomBarWhenPushed = NO;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.weiboStatuses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *requerId = @"homeCell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:requerId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:requerId];
    }
    CDStatus *status = self.weiboStatuses[indexPath.row];
    cell.textLabel.text = status.user.name;
    [cell.imageView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    cell.textLabel.text = status.text;
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
