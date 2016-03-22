//
//  CDPhotoView.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/21.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDPhotoView.h"
#import "CDUitiity.h"
#import "UIImageView+WebCache.h"


@interface CDPhotoView ()

@property (nonatomic, weak) UIImageView *gifView;


@end


@implementation CDPhotoView



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setUpAllChildView];
        self.contentMode = UIViewContentModeScaleAspectFill;
        // 裁剪图片，超出控件的部分裁剪掉
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
    }
    
    return self;
}


- (void) setUpAllChildView
{
    UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
    [self addSubview:gifView];
    _gifView = gifView;
}


- (void)setPhoto:(CDWeiboPhoto *)photo
{
    _photo = photo;
    // 赋值
    [self sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    // 判断下是否显示gif
    NSString *urlStr = photo.thumbnail_pic.absoluteString;
    if ([urlStr hasSuffix:@".gif"]) {
        self.gifView.hidden = NO;
    }else{
        self.gifView.hidden = YES;
    }

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;

}



@end
