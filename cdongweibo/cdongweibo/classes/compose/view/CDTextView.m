//
//  CDTextView.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/22.
//  Copyright © 2016年 man. All rights reserved.
//

#import "CDTextView.h"
#import "UIView+Frame.h"

@interface CDTextView ()

@property (nonatomic,weak) UILabel *holderLab;


@end

@implementation CDTextView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
         self.font = [UIFont systemFontOfSize:13];
        
    }
    return self;
}



- (void)setHidePlaceHolder:(BOOL)hidePlaceHolder
{
    _hidePlaceHolder = hidePlaceHolder;
    
    self.holderLab.hidden = _hidePlaceHolder;
    [self.holderLab sizeToFit];
}

- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = placeHolder;
    
    self.holderLab.text = placeHolder;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.holderLab.font = font;
    [self.holderLab sizeToFit];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.holderLab.x = 5;
    self.holderLab.y =8;

}

/**
 *  需要用holderLab时候才加载
 *
 *  @return holderLab
 */
- (UILabel *)holderLab
{
    if (_holderLab==nil) {
        UILabel *holderLab = [[UILabel alloc] init];
        
        [self addSubview:holderLab];
        _holderLab = holderLab;
    }

    return _holderLab;
}


@end
