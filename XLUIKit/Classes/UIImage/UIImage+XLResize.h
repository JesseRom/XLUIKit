//
//  UIImage+XLResize.h
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (XLResize)

/**
 *  从中心位置拉伸图片
 *
 *  @return 拉伸后的图片
 */
- (UIImage *)xl_autoStretchImage;

- (UIImage *)xl_autoResize;

- (UIImage *)xl_roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;

- (UIImage *)xl_thumbnailImage:(NSInteger)thumbnailSize
              transparentBorder:(NSUInteger)borderSize
                   cornerRadius:(NSUInteger)cornerRadius
           interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)xl_resizedImage:(CGSize)newSize
         interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)xl_resizedImageWithContentMode:(UIViewContentMode)contentMode
                                      bounds:(CGSize)bounds
                        interpolationQuality:(CGInterpolationQuality)quality;
@end

