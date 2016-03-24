//
//  NSData+CD.h
//  cdongweibo
//
//  Created by 陈栋 on 16/3/24.
//  Copyright © 2016年 man. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (CD)

/**
 *  获取图片类型
 *
 *  @param data 图片二进制文件
 *
 *  @return 图片mimeType image/jpeg,image/png,image/gif,image/tiff
 */
+ (NSString *)mimetypeForImageData:(NSData *)data;


/**
 *  获取二进制图片文件名
 *
 *  @param data 图片二进制文件
 *
 *  @return 图片文件名 jpg.png.gif,tiff
 */
+ (NSString *)typeNameForImageData:(NSData *)data;

@end
