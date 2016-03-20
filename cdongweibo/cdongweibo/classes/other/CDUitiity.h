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
#define CD_UI_MARGIN_10 10
#define CD_UI_FONT_10 [UIFont systemFontOfSize:10]
#define CD_UI_FONT_11 [UIFont systemFontOfSize:11]
#define CD_UI_FONT_12 [UIFont systemFontOfSize:12]
#define CD_UI_FONT_13 [UIFont systemFontOfSize:13]
#define CD_UI_FONT_14 [UIFont systemFontOfSize:14]
#define CD_UI_FONT_15 [UIFont systemFontOfSize:15]
#define CD_NAME_FONT CD_UI_FONT_13
#define CD_TIME_FONT CD_UI_FONT_12
#define CD_SOURCE_FONT CD_TIME_FONT
#define CD_TEXT_FONT CD_UI_FONT_14

#define CDKeyWindow [UIApplication sharedApplication].keyWindow

// ...表示宏定义的可变参数
// __VA_ARGS__:表示函数里面的可变参数
#ifdef DEBUG //测试

#define CDLog(...) NSLog(__VA_ARGS__)

#else //发布

#define CDLog(...)

#endif

#endif