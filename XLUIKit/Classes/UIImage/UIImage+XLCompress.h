//
//  UIImage+XLCompress.h
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (XLCompress)

- (NSData *)xl_compressedJPEGImageData;

+ (UIImage *)xl_compressedImage:(UIImage *)image maxDataSize:(NSUInteger)dataSize;

/**
 *  解压缩图片到 size 大小
 *
 *  @param targetSize 解压缩后尺寸
 *
 *  @return 解压缩到 size 尺寸的图片
 */
- (UIImage *)xl_decompressWithSize:(CGSize)targetSize;

- (NSData *)xl_compressedImageDataForShare;
@end
