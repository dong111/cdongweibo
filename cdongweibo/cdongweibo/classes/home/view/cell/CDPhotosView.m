//
//  CDPhotosView.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/21.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDPhotosView.h"

@implementation CDPhotosView


//初始化视图设置
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}


- (void)setStatusFrame:(CDStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;

    
}







@end
