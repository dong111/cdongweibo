//
//  CDTextView.h
//  cdongweibo
//
//  Created by 陈栋 on 16/3/22.
//  Copyright © 2016年 man. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDTextView : UITextView
/**
 * 占位符内容
 */
@property (nonatomic,copy) NSString *placeHolder;

/**
 *  是否隐藏placholder
 */
@property (nonatomic,assign) BOOL hidePlaceHolder;

@end
