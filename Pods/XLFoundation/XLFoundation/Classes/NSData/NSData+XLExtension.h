//
//  NSData+XLExtension.h
//  XLFoundation
//
//  Created by HONGLUO on 2018/8/2.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData(XLExtension)

+ (BOOL)mzd_isPNGForImageData:(NSData *)data;
+ (BOOL)mzd_isJPEGForImageData:(NSData *)data;

@end
