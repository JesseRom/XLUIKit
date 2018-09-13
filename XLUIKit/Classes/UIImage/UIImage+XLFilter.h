//
//  UIImage+XLFilter.h
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (XLFilter)
/**
 *  黑白滤镜
 *
 *  @return 黑白图片
 */
- (UIImage*)xl_grayScaleImage;

/**
 *  混合 maskImage 图层后的图片
 *
 *  @param maskImage 遮罩图层
 *
 *  @return 混合图片
 */
- (UIImage *)xl_imageWithMask:(UIImage *)maskImage;

/**
 *  为图片加入混合色，blendMode 为 kCGBlendModeSourceAtop
 *
 *  @param tintColor 混合的色值
 *
 *  @return 上色后的图片
 */
- (UIImage *)xl_tintedImageWithColor:(UIColor *)tintColor;

/**
 *  将图片上色, 透明部分不处理 blendMode 为 kCGBlendModeDestinationIn
 *
 *  @param color 上色色值
 *
 *  @return color 色的图片
 */
- (UIImage *)xl_hollowOutWithColor:(UIColor *)color;

@end
