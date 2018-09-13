//
//  UIColor+XLExtension.h
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColor (XLExtension)
/**
 *  生成一个随机色, 默认不透明
 *
 *  @return 随机色 UIColor 对象
 */
+ (UIColor *)xl_randomColor;

/**
 *  生成一个随机色，可设置颜色的 alpha 值
 *
 *  @param alpha 颜色 alpha 值，范围 0 - 1
 *
 *  @return 随机色 UIColor 对象
 */
+ (UIColor *)xl_randomColor:(CGFloat)alpha;

/**
 *  通过 16 进制色值生成 UIColor 对象, 支持 3，6，8 位，可加 # 或 0x 前缀，如
 *
 *  @param hex 16 进制色值，支持 3，6，8 位，可加 # 或者 0x 前缀，如:
 *             fff ffffff ffffffff
 *             #fff #ffffff #ffffff
 *             0xfff 0xffffff 0xffffffff
 *
 *  @return 16 进制色值对应 UIColor 对象
 */
+ (UIColor *)xl_colorWithHex:(NSString *)hex;

/**
 *  UIColor 对象对应的 16 进制色值, 忽略 alpha 通道
 *
 *  @return 返回 16 进制色值字符串，格式 ffffff
 */
- (NSString *)xl_hexValue;

/**
 *  UIColor 对象对应的 16 进制色值
 *
 *  @param includeAlpha 是否包含 alpha 通道
 *
 *  @return 返回 16 进制色值字符串，包含 alpha 通道格式为 ffffffff， 不包含为 ffffff
 */
- (NSString *)xl_hexValueWithAlpha:(BOOL)includeAlpha;

/**
 *  UIColor 的 Red 色值
 *
 *  @return 范围 0 - 1
 */
- (CGFloat)xl_red;

/**
 *  UIColor 的 Green 色值
 *
 *  @return 范围 0 - 1
 */
- (CGFloat)xl_green;

/**
 *  UIColor 的 Blue 色值
 *
 *  @return 范围 0 - 1
 */
- (CGFloat)xl_blue;

/**
 *  UIColor 的 Alpha 通道值
 *
 *  @return 范围 0 - 1
 */
- (CGFloat)xl_alpha;
@end

