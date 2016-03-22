//
//  CDPhotoView.h
//  cdongweibo
//  显示图片的photoView 如果是git显示gif图片
//  Created by 陈栋 on 16/3/21.
//  Copyright © 2016年 man. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDWeiboPhoto.h"


@interface CDPhotoView : UIImageView

@property (nonatomic, strong) CDWeiboPhoto *photo;


@end
