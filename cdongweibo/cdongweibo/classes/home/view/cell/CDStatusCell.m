//
//  CDStatusCellTableViewCell.m
//  cdongweibo
//  自定义status显示cell 包含三个控件 （原创微博，转发微博，tabbar）
//
//  Created by 陈栋 on 16/3/19.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDStatusCell.h"

@interface CDStatusCell ()
/**
 *  原创微博
 */
@property (nonatomic,weak) CDOriginaView *originaView;
/**
 * 转发微博
 */
@property (nonatomic,weak) CDRetweetView *retWeetView;
/**
 *  tabbar）
 */
@property (nonatomic,weak) CDStatusBarView *statusBar;
@end

@implementation CDStatusCell

//**注意:cell是用InitwithStyle初始化的不是frame
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       //添加所有子控件
        [self setUpAllChildView];
        //清空背景颜色
        self.backgroundColor  = [UIColor clearColor];
    }
    return self;
}

//添加所有子控件
- (void)setUpAllChildView
{
    //原创微博
    CDOriginaView *originaView = [[CDOriginaView alloc] init];
    [self addSubview:originaView];
    _originaView = originaView;
    //转发微博
    CDRetweetView *retWeetView = [[CDRetweetView alloc] init];
    [self addSubview:retWeetView];
    _retWeetView = retWeetView;
    //tabbar）
    CDStatusBarView *statusBar = [[CDStatusBarView alloc] init];
    [self addSubview:statusBar];
    _statusBar = statusBar;

}
/*
 问题：1.cell的高度应该提前计算出来
 2.cell的高度必须要先计算出每个子控件的frame，才能确定
 3.如果在cell的setStatus方法计算子控件的位置，会比较耗性能
 
 解决:MVVM思想
 M:模型
 V:视图
 VM:视图模型（模型包装视图模型，模型+模型对应视图的frame）
 
 
 */
- (void)setStatusFrame:(CDStatusFrame *)statusFrame
{

    _statusFrame = statusFrame;
     // 设置原创微博frame 和数据
    _originaView.statusFrame = statusFrame;
    _originaView.frame = _statusFrame.originalViewFrame;
    
    // 设置原创微博frame
    _retWeetView.frame = _statusFrame.retWeetViewFrame;
    _retWeetView.statusFrame = _statusFrame;
    
    // 设置工具条frame
    _statusBar.frame = _statusFrame.statusBarViewFrame;
    _statusBar.statusFrame = _statusFrame;
}


/**
 *  初始化cell 带有cell缓冲池
 *
 *  @param tableView 需要cell的table
 *
 *  @return 自定义cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *requerId = @"homeCell";
    
    CDStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:requerId];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:requerId];
    }

    return cell;
}


@end
