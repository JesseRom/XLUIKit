//
//  UIImage+XLBlur.h
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (XLBlur)

/**
 *  图片高斯模糊效果
 *
 *  @param radius     模糊半径
 *  @param iterations 迭代度
 *  @param tintColor  模糊混合色 blendMode 为 kCGBlendModePlusDarker
 *
 *  @return 高斯模糊图片
 */
- (UIImage *)xl_blurWithRadius:(CGFloat)radius iterations:(NSInteger)iterations tintColor:(UIColor *)tintColor;

+ (UIImage *)xl_boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

- (UIImage *)xl_gaussianBlurWithRadius:(NSInteger)radius;
@end
