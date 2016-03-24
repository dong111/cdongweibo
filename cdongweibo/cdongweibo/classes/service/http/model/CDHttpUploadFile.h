//
//  CDHttpUploadFile.h
//  cdongweibo
//
//  Created by 陈栋 on 16/3/24.
//  Copyright © 2016年 man. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDHttpUploadFile : NSObject

/**
 *  二进制文件
 */
@property (nonatomic,strong) NSData *data;
/**
 *  上传参数名称
 */
@property (nonatomic,copy) NSString *name;

/**
 *  上传服务器的文件名称
 */
@property (nonatomic,copy) NSString *fileName;

/**
 *  文件类型
 */
@property (nonatomic,copy) NSString *mimeType;

@end
