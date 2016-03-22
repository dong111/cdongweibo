//
//  CDPhotosView.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/21.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDPhotosView.h"
#import "CDUitiity.h"
#import "CDWeiboPhoto.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "CDPhotoView.h"

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
        
        CDPhotoView *photoView = [[CDPhotoView alloc] init];

//        UIGestureRecognizer *gesture = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(showImagesBrowse)];
        photoView.tag = i;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImagesBrowse:)];
        [photoView addGestureRecognizer:gesture];
        [self addSubview:photoView];

    }
    
}

#pragma mark 显示图片浏览器
- (void) showImagesBrowse:(UITapGestureRecognizer *)tap
{
    UIImageView *tapView = tap.view;
    NSMutableArray *photoArray = [NSMutableArray array];
    for (CDWeiboPhoto *photo in _pic_urls) {
        MJPhoto *mjPhoto = [[MJPhoto alloc] init];
        NSString *urlStr = photo.thumbnail_pic.absoluteString;
        urlStr = [urlStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        mjPhoto.url = [NSURL URLWithString:urlStr];
        [photoArray addObject:mjPhoto];
    }
    
    MJPhotoBrowser *photoBrow = [[MJPhotoBrowser alloc] init];
    photoBrow.photos = photoArray;
    photoBrow.currentPhotoIndex = tapView.tag;
    [photoBrow show];
}




- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    int childCount = self.subviews.count;
    
    for (UIView *subView in self.subviews) {
        subView.hidden = YES;
    }
    
    for (int i=0; i<_pic_urls.count; i++) {
       CDPhotoView *imageV =  self.subviews[i];
        if (i<childCount) {//显示
            imageV.hidden = NO;
            //或去url
             CDWeiboPhoto *photo = _pic_urls[i];
            [imageV setPhoto:photo];
            
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
