//
//  UIImage+XLCreate.h
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (XLCreate)
/**
 * 根据颜色生成图片
 * @param color 色值
 * @return image 对象
 */
+ (UIImage *)xl_imageWithColor:(UIColor *)color;

/**
 *  根据颜色和尺寸生成图片
 *
 *  @param color 色值
 *  @param size  尺寸
 *
 *  @return 色值 image 对象
 */
+ (UIImage *)xl_imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 * 根据颜色、尺寸、圆角生成图片
 *
 * @param size  尺寸
 * @param color 色值
 * @param radius 圆角
 * @return image 对象
 */
+ (UIImage *)xl_imageWithSize:(CGSize)size color:(UIColor *)color cornerRadius:(CGFloat)radius;

/**
 获取颜色渐变的image
 
 @param colorArr @[(id) [UIColor xl_colorWithHex:@"03d6cd"].CGColor, (id) [UIColor xl_colorWithHex:@"12e3b6"].CGColor]
 @param size <#size description#>
 @param locations @[@0, @1]
 @param startPoint CGPointMake(0, 0)
 @param endPoint CGPointMake(1, 0)
 @param radius <#radius description#>
 @return <#return value description#>
 */
+ (UIImage *)xl_gradientImageWithColor:(NSArray *)colorArr
                                   size:(CGSize)size
                              locations:(NSArray<NSNumber *> *)locations
                             startPoint:(CGPoint)startPoint
                               endPoint:(CGPoint)endPoint
                           cornerRadius:(CGFloat)radius;

- (UIImage *)xl_drawImage:(UIImage *)inputImage inRect:(CGRect)frame;



@end
