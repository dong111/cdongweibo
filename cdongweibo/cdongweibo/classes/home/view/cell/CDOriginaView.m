//
//  CDOriginaView.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/19.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDOriginaView.h"
#import "CDUitiity.h"
#import "UIImageView+WebCache.h"
#import "CDPhotosView.h"

@interface CDOriginaView ()

// 头像
@property (nonatomic, weak) UIImageView *iconView;


// 昵称
@property (nonatomic, weak) UILabel *nameView;


// vip
@property (nonatomic, weak) UIImageView *vipView;


// 时间
@property (nonatomic, weak) UILabel *timeView;

// 来源
@property (nonatomic, weak) UILabel *sourceView;


// 正文
@property (nonatomic, weak) UILabel *textView;

//图片
@property (nonatomic,weak) CDPhotosView *photosView;

@end

@implementation CDOriginaView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //添加所有子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:[UIImage imageNamed:@"timeline_card_top_background"]];
    }
    return self;
}

- (void) setUpAllChildView
{
    //头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
    
    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.font = CD_NAME_FONT;
    [self addSubview:nameView];
    _nameView = nameView;
    
    // vip
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    _vipView = vipView;
    
    
    // 时间
    UILabel *timeView = [[UILabel alloc] init];
    timeView.font = CD_TIME_FONT;
    timeView.textColor = [UIColor orangeColor];
    [self addSubview:timeView];
    _timeView = timeView;
    
    // 来源
    UILabel *sourceView = [[UILabel alloc] init];
    sourceView.font = CD_SOURCE_FONT;
    [self addSubview:sourceView];
    _sourceView = sourceView;
    
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
//    NSLog(@"%@",statusFrame);
    // 设置frame
    [self setUpFrame];
    // 设置data
    [self setUpData];

}
/**
 *  设置frame
 */
- (void) setUpFrame
{
    _iconView.frame = _statusFrame.originalIconFrame;

    // 昵称
    _nameView.frame = _statusFrame.originalNameFrame;
    
    // vip
    if (_statusFrame.status.user.vip) { // 是vip
        _vipView.hidden = NO;
        _vipView.frame = _statusFrame.originalVipFrame;
    }else{
        _vipView.hidden = YES;
    }
    
    
    // 时间 每次有新的时间都需要计算时间frame
    CDStatus *status = _statusFrame.status;
    // 时间Frame
    CGFloat timeX = _nameView.frame.origin.x;
    CGFloat timeY = CGRectGetMaxY(_nameView.frame) + CD_UI_MARGIN_10 * 0.5;
    CGSize timeSize = [status.created_at sizeWithFont:CD_TIME_FONT];
    _timeView.frame = (CGRect){{timeX,timeY},timeSize};
    
    // 来源Frame
    CGFloat sourceX = CGRectGetMaxX(_timeView.frame) + CD_UI_MARGIN_10;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:CD_SOURCE_FONT];
    _sourceView.frame = (CGRect){{sourceX,sourceY},sourceSize};
    
    
    // 正文
    _textView.frame = _statusFrame.originalTextFrame;

    //图片
    if (status.pic_urls.count) {
        _photosView.frame = _statusFrame.originalPhotosFrame;
    }
    
}
/**
 *  设置data
 */
- (void) setUpData
{
    CDStatus *status = _statusFrame.status;
    // 头像
    [_iconView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    // 昵称
    if (status.user.vip) {
        _nameView.textColor = [UIColor redColor];
    }else{
        _nameView.textColor = [UIColor blackColor];
    }
    _nameView.text = status.user.name;
    
    // vip
    NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank];
    UIImage *image = [UIImage imageNamed:imageName];
    
    _vipView.image = image;
    
    // 时间
    _timeView.text = status.created_at;
    
    // 来源
    
    _sourceView.text = status.source;
    
    // 正文
    _textView.text = status.text;
    
    //图片
    if (status.pic_urls) {
        [_photosView setPic_urls:status.pic_urls];
    }
    
}


@end
