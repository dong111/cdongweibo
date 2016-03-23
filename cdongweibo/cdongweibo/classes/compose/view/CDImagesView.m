//
//  CDImagesView.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/23.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDImagesView.h"
#import "UIView+Frame.h"

@interface CDImagesView ()


//总体图片数组
@property (nonatomic,strong) NSMutableArray *images;

@end

@implementation CDImagesView

- (NSMutableArray *)images
{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}



-(void)addImage:(UIImage *)image
{
    if (image==nil) {
        return;
    }
    [self.images addObject:image];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    [self addSubview:imageView];
}

- (void) initParams
{
    if (_cols==0) {
        _cols=3;
    }
    if (_margin==0) {
        _margin =10;
    }
    
    if (_imageW==0) {
        _imageW=70;
    }
    if (_imageH==0) {
        _imageH=70;
    }
    //如果view frame已经被设置了 就自动计算
    if (self.width>0) {
        CGFloat marginWidth= (_cols-1)*_margin;
        _imageW=(self.width-marginWidth)/_cols;
        _imageH=_imageW;
    }
    
    
}

- (void)layoutSubviews
{
    //初始化参数
    [self initParams];
    int i=0;
    for (UIImageView *imageView in self.subviews) {
        CGFloat imageX = (_imageW+_margin)*(i%_cols);
        CGFloat imagey = (_imageH+_margin)*(i/_cols);
        
        imageView.frame = CGRectMake(imageX, imagey, _imageW, _imageH);
        i++;
    }

}


@end
