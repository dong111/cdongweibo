//
//  CDNewFeatureCell.h
//  cdongweibo
//
//  Created by 陈栋 on 16/3/16.
//  Copyright © 2016年 man. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDNewFeatureCell : UICollectionViewCell

- (void) setImage:(UIImage *)image;

//判断是否是最后一页
- (void) setIndexPath:(NSIndexPath *)indexPath count:(int) count;

@end
