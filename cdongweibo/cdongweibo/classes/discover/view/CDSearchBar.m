//
//  CDSearchBar.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/15.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDSearchBar.h"
#import "CDUitiity.h"

@implementation CDSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setBackground:[UIImage imageWithStretchableName:[UIImage imageNamed:@"searchbar_textfield_background"]]];
        UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        leftView.width +=10;
        leftView.contentMode = UIViewContentModeCenter;//内容居中显示
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        //    searchBar.backgroundColor = [UIColor orangeColor];
        self.placeholder = @"大家都在搜";
        //字体大小设置
        self.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

@end
