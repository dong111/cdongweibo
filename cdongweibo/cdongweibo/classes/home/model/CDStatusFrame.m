//
//  CDStatusFrame.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/19.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDStatusFrame.h"
#import "CDStatus.h"
#import "CDUitiity.h"



@implementation CDStatusFrame

- (void)setStatus:(CDStatus *)status
{
    _status = status;

    //计算原创微博frame
    [self calculateOriginalView];
     CGFloat toolBarY = CGRectGetMaxY(_originalViewFrame);
    //计算转发微博frame
    if (_status.retweeted_status) {
        // 计算转发微博
        [self calculateRetWeetView];
        
        toolBarY = CGRectGetMaxY(_retWeetViewFrame);
    }
    //计算StatusBar frame
    [self calculateStatusBarView:toolBarY];
    
    // 计算cell高度
    _heigth = CGRectGetMaxY(_statusBarViewFrame);
    
    
}
//计算原创微博frame
- (void) calculateOriginalView
{
    // 头像Frame
    CGFloat imageX = CD_UI_MARGIN_10;
    CGFloat imageY = imageX;
    CGFloat imageWH = 35;
    _originalIconFrame = CGRectMake(imageX, imageY, imageWH, imageWH);
    
    // 昵称Frame
    CGFloat nameX = CGRectGetMaxX(_originalIconFrame) + CD_UI_MARGIN_10;
    CGFloat nameY = imageY;
    CGSize nameSize = [_status.user.name sizeWithFont:CD_NAME_FONT];
    _originalNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    // vipFrame
    if (_status.user.isVip) {
        CGFloat vipX = CGRectGetMaxX(_originalNameFrame) + CD_UI_MARGIN_10;
        CGFloat vipY = nameY;
        CGFloat vipWH = 14;
        _originalVipFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
    }

    //交给view计算  view每次刷新都需要从新计算
    
//    // 时间Frame
//    CGFloat timeX = nameX;
//    CGFloat timeY = CGRectGetMaxY(_originalNameFrame) + CD_UI_MARGIN_10 * 0.5;
//    CGSize timeSize = [_status.created_at sizeWithFont:CD_TIME_FONT];
//    _originalTimeFrame = (CGRect){{timeX,timeY},timeSize};
//    
//    // 来源Frame
//    CGFloat sourceX = CGRectGetMaxX(_originalTimeFrame) + CD_UI_MARGIN_10;
//    CGFloat sourceY = timeY;
//    CGSize sourceSize = [_status.source sizeWithFont:CD_SOURCE_FONT];
//    _originalSourceFrame = (CGRect){{sourceX,sourceY},sourceSize};
    
    // 正文Frame
    CGFloat textX = imageX;
    CGFloat textY = CGRectGetMaxY(_originalIconFrame) + CD_UI_MARGIN_10;
    
    CGFloat textW = SCREEN_WIDTH - 2 * CD_UI_MARGIN_10;
    CGSize textSize = [_status.text sizeWithFont:CD_TIME_FONT constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _originalTextFrame = (CGRect){{textX,textY},textSize};
    
    //计算photosframe
    // 配图
    if (_status.pic_urls.count) {
        CGFloat photosX = CD_UI_MARGIN_10;
        CGFloat photosY = CGRectGetMaxY(_originalTextFrame) + CD_UI_MARGIN_10;
        CGSize photosSize = [self photosSizeWithCount:_status.pic_urls.count];
        _originalPhotosFrame = (CGRect){{photosX,photosY},photosSize};
    }

    
    // 原创微博的frame
    CGFloat originX = 0;
    CGFloat originY = 10;
    CGFloat originW = SCREEN_WIDTH;
    CGFloat originH = CGRectGetMaxY(_originalTextFrame) + CD_UI_MARGIN_10;
    // 配图
    if (_status.pic_urls.count) {
        originH = CGRectGetMaxY(_originalPhotosFrame) + CD_UI_MARGIN_10;
    }
    _originalViewFrame = CGRectMake(originX, originY, originW, originH);
}

#pragma mark - 计算配图的尺寸
- (CGSize)photosSizeWithCount:(int)count
{
    // 获取总列数
    int cols = count == 4? 2 : 3;
    // 获取总行数 = (总个数 - 1) / 总列数 + 1
    int rols = (count - 1) / cols + 1;
    CGFloat photoWH = 70;
    CGFloat w = cols * photoWH + (cols - 1) * CD_UI_MARGIN_10;
    CGFloat h = rols * photoWH + (rols - 1) * CD_UI_MARGIN_10;
    
    return CGSizeMake(w, h);
    
}


//计算原创微博frame
- (void) calculateRetWeetView
{
    // 昵称frame
    // 昵称
    CGFloat nameX = CD_UI_MARGIN_10;
    CGFloat nameY = nameX;
    // 注意：一定要是转发微博的用户昵称
    CGSize nameSize = [_status.retweeted_name sizeWithFont:CD_NAME_FONT];
    _retweetNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    // 正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(_retweetNameFrame) + CD_UI_MARGIN_10;
    
    
    CGFloat textW = SCREEN_WIDTH - 2 * CD_UI_MARGIN_10;
    // 注意：一定要是转发微博的正文
#warning constrainedToSize 方法含义
    CGSize textSize = [_status.retweeted_status.text sizeWithFont:CD_TIME_FONT constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _retweetTextFrame = (CGRect){{textX,textY},textSize};
    
    
    //计算photosframe
    // 配图
    if (_status.retweeted_status.pic_urls.count) {
        CGFloat photosX = CD_UI_MARGIN_10;
        CGFloat photosY = CGRectGetMaxY(_retweetTextFrame) + CD_UI_MARGIN_10;
        CGSize photosSize = [self photosSizeWithCount:_status.retweeted_status.pic_urls.count];
        _retweetPhotosFrame = (CGRect){{photosX,photosY},photosSize};
    }
    
    
    // 原创微博的frame
    CGFloat retweetX = 0;
    CGFloat retweetY = CGRectGetMaxY(_originalViewFrame);
    CGFloat retweetW = SCREEN_WIDTH;
    CGFloat retweetH = CGRectGetMaxY(_retweetTextFrame) + CD_UI_MARGIN_10;
    // 配图
    if (_status.retweeted_status.pic_urls.count) {
        retweetH = CGRectGetMaxY(_retweetPhotosFrame) + CD_UI_MARGIN_10;
    }
    
    _retWeetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);
    
    
}

//计算StatusBar frame
- (void) calculateStatusBarView:(CGFloat) toolBarY
{

    CGFloat toolBarX = 0;
    CGFloat toolBarW = SCREEN_WIDTH;
    CGFloat toolBarH = 35;
    _statusBarViewFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);

}


- (NSString *)description
{
    return [NSString stringWithFormat:@"name = %@,originalViewFrame = %@,retWeetViewFrame = %@,statusBarViewFrame = %@"
            ,_status.user.name,NSStringFromCGRect(_originalViewFrame),NSStringFromCGRect(_retWeetViewFrame),NSStringFromCGRect(_statusBarViewFrame)];

}

@end
