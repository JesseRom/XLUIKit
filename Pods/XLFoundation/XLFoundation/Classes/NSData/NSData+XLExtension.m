//
//  NSData+XLExtension.m
//  XLFoundation
//
//  Created by HONGLUO on 2018/8/2.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "NSData+XLExtension.h"

@implementation NSData(XLExtension)

+ (BOOL)mzd_isPNGForImageData:(NSData *)data {
    NSString *type = [NSData mzd_contentTypeForImageData:data];
    return [type isEqualToString:@"image/png"];
}

+ (BOOL)mzd_isJPEGForImageData:(NSData *)data {
    NSString *type = [NSData mzd_contentTypeForImageData:data];
    return [type isEqualToString:@"image/jpeg"];
}

+ (NSString *)mzd_contentTypeForImageData:(NSData *)data {
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
            case 0x52:
            // R as RIFF for WEBP
            if ([data length] < 12) {
                return nil;
            }
            
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"image/webp";
            }
            
            return nil;
    }
    return nil;
}

@end
