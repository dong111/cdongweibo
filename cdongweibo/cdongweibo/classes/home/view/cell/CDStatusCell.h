//
//  CDStatusCellTableViewCell.h
//  cdongweibo
//
//  Created by 陈栋 on 16/3/19.
//  Copyright © 2016年 man. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDOriginaView.h"
#import "CDRetweetView.h"
#import "CDStatusBarView.h"


@interface CDStatusCell : UITableViewCell

@property (nonatomic,strong) CDStatusFrame *statusFrame;

/**
 *  自定义tableCell
 *
 *  @param tableView 需要cell的tableView

 *
 *  @return 自定义tableCell

 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
