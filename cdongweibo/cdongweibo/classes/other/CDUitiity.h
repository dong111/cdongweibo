//
//  CDUitiity.h
//  cdongweibo
//

//类似pch文件功能

//  Created by 陈栋 on 16/3/15.
//  Copyright © 2016年 man. All rights reserved.
//

#ifndef cdongweibo_utility.h
#define cdongweibo_utility.h

#import "UIView+Frame.h"
#import "UIImage+CDImage.h"


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define CDKeyWindow [UIApplication sharedApplication].keyWindow

// ...表示宏定义的可变参数
// __VA_ARGS__:表示函数里面的可变参数
#ifdef DEBUG //测试

#define CDLog(...) NSLog(__VA_ARGS__)

#else //发布

#define CDLog(...)

#endif

#endif