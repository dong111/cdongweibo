//
//  CDRetweetView.m
//  cdongweibo
//  转发微博显示转发内容
//  Created by 陈栋 on 16/3/19.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDRetweetView.h"
#import "CDUitiity.h"
#import "CDPhotosView.h"

@interface CDRetweetView ()


// 昵称
@property (nonatomic, weak) UILabel *nameView;

// 正文
@property (nonatomic, weak) UILabel *textView;

//图片
@property (nonatomic,weak) CDPhotosView *photosView;

@end

@implementation CDRetweetView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //添加所有子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:[UIImage imageNamed:@"timeline_retweet_background"]];
    }
    return self;
}
/**
 *  添加子控件
 */
- (void) setUpAllChildView
{
 
    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.font = CD_NAME_FONT;
    nameView.textColor = [UIColor blueColor];
    [self addSubview:nameView];
    _nameView = nameView;
    
    
    // 正文
    UILabel *textView = [[UILabel alloc] init];
    textView.font = CD_TEXT_FONT;
    textView.numberOfLines = 0;
    [self addSubview:textView];
    _textView = textView;
    
    
    //图片
    CDPhotosView *photosView =[[CDPhotosView alloc] init];
    [self addSubview:photosView];
    _photosView = photosView;
    
    
    
}


- (void)setStatusFrame:(CDStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    CDStatus *status = _statusFrame.status;
    // 昵称
    _nameView.frame = _statusFrame.retweetNameFrame;
    _nameView.text = status.retweeted_name;
    
    // 正文
    _textView.frame = _statusFrame.retweetTextFrame;
    _textView.text = status.retweeted_status.text;

    //图片
    if (status.retweeted_status.pic_urls.count) {
        _photosView.frame = _statusFrame.retweetPhotosFrame;
        _photosView.pic_urls =status.retweeted_status.pic_urls;
    }
    
}

\

@end
