//
//  CDComposeToolBar.h
//  cdongweibo
//
//  Created by 陈栋 on 16/3/22.
//  Copyright © 2016年 man. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CDComposeToolBar;
@protocol CDComposeToolBarDelegate <NSObject>

@optional
- (void) composeToolBar:(CDComposeToolBar *)toolBar DidClickBtn:(int) index;

@end

@interface CDComposeToolBar : UIView

@property (nonatomic,weak) id<CDComposeToolBarDelegate> delegate;

@end
