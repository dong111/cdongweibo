//
//  CDPhotosView.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/21.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDPhotosView.h"
#import "UIImageView+WebCache.h"
#import "CDUitiity.h"
#import "CDWeiboPhoto.h"

@interface CDPhotosView ()



@end

@implementation CDPhotosView



//初始化视图设置
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
        [self setUpAllChildView];
    }
    return self;
}
// 添加所有子控制器
- (void) setUpAllChildView
{

    for (int i=0; i<9; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        // 裁剪图片，超出控件的部分裁剪掉
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];

    }
    
}




- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    int childCount = self.subviews.count;
    
    for (int i=0; i<_pic_urls.count; i++) {
       UIImageView *imageV =  self.subviews[i];
        if (i<childCount) {//显示
            imageV.hidden = NO;
            //或去url
             CDWeiboPhoto *photo = _pic_urls[i];
            [imageV sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            
        }else{
            //隐藏
            imageV.hidden = YES;
        }
    }

}
//计算尺寸
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 70;
    CGFloat h = 70;
    int col = 0;
    int rol = 0;
    int cols = _pic_urls.count==4?2:3;
    
    // 计算显示出来的imageView
    for (int i = 0; i < _pic_urls.count; i++) {
        col = i % cols;
        rol = i / cols;
        UIImageView *imageV = self.subviews[i];
        x = col * (w + CD_UI_MARGIN_10);
        y = rol * (h + CD_UI_MARGIN_10);
        imageV.frame = CGRectMake(x, y, w, h);
    }
    

}




@end
