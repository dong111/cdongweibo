//
//  CDStatusBar.m
//  cdongweibo
//  微博内容状态bar
//  Created by 陈栋 on 16/3/19.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDStatusBarView.h"
#import "CDUitiity.h"

@interface CDStatusBarView ()

/**
 *  转发按钮
 */
@property (nonatomic,weak) UIButton *retWeet;

/**
 *  转发按钮
 */
@property (nonatomic,weak) UIButton *comment;

/**
 *  转发按钮
 */
@property (nonatomic,weak) UIButton *unike;

//记录工具按钮数组
@property (nonatomic, strong) NSMutableArray *btns;



@end


@implementation CDStatusBarView


- (NSMutableArray *)btns
{
    if (_btns==nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //添加所有子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:[UIImage imageNamed:@"timeline_card_bottom_background"]];
//        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}
//添加所有子控制器
- (void) setUpAllChildView
{

    // 转发
    UIButton *retWeet = [self setUpOneButtonWithImage:[UIImage imageNamed:@"timeline_icon_retweet"] title:@"转发"];
    self.retWeet = retWeet;
    //评论
    UIButton *comment = [self setUpOneButtonWithImage:[UIImage imageNamed:@"timeline_icon_comment"] title:@"评论"];
     self.comment = comment;
    //赞
    UIButton *unike = [self setUpOneButtonWithImage:[UIImage imageNamed:@"timeline_icon_unlike"] title:@"赞"];
    self.unike = unike;

}

- (void)layoutSubviews
{
    //设置frame
    for (int i=0; i<self.btns.count; i++) {
        UIButton *btn = self.btns[i];
        CGFloat btnW = SCREEN_WIDTH /3;
        CGFloat btnH = self.height;
        CGFloat btnX = i*btnW;
        CGFloat btny = 0;
        btn.frame = CGRectMake(btnX, btny, btnW, btnH);
        if (i>0) {//添加分割线
            [self addDividLine:btn.frame];
        }
    }
}


/**
 *  添加按钮前分割线
 *
 *  @param frame 需要添加分割线按钮的frame
 */
- (void) addDividLine:(CGRect) frame
{
    
    CGFloat labelW = 0;
    CGFloat labelH = 0;
    CGFloat labelX = frame.origin.x;
    CGFloat labely = 0;
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(labelX, labely, labelW, labelH)];
    [imageV setImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
    [imageV sizeToFit];
    [self addSubview:imageV];


}

- (UIButton *)setUpOneButtonWithImage:(UIImage *)image title:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    [self addSubview:btn];
    [self.btns addObject:btn];
    return btn;
}





- (void)setStatusFrame:(CDStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    CDStatus *status = _statusFrame.status;
    
    // 设置转发的标题
    [self setBtn:_retWeet title:status.reposts_count];
    
    // 设置评论的标题
    [self setBtn:_comment title:status.comments_count];
    
    // 设置赞
    [self setBtn:_unike title:status.attitudes_count];
    
}


// 设置按钮的标题
- (void)setBtn:(UIButton *)btn title:(int)count
{
    // > 10000 10100 1.2W
    NSString *title = nil;
    if (count) {
        
        if (count > 10000) {
            CGFloat floatCount = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1fW",floatCount];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }else{ // < 10000
            title = [NSString stringWithFormat:@"%d",count];
        }
        
        
        // 设置转发
        [btn setTitle:title forState:UIControlStateNormal];
    }
}


@end
