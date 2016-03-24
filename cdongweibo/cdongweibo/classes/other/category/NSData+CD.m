//
//  NSData+CD.m
//  cdongweibo
//
//  Created by 陈栋 on 16/3/24.
//  Copyright © 2016年 man. All rights reserved.
//

#import "NSData+CD.h"

@implementation NSData (CD)

+ (NSString *)mimetypeForImageData:(NSData *)data
{
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
    }
    return @"image/jpeg";
}

+ (NSString *)typeNameForImageData:(NSData *)data
{
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"jpg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
    }
    return @"jpg";
}


@end
