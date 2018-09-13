//
//  UIButton+XLExtension.h
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIButton (XLExtension)
/**
 设置按钮的图片和文字垂直对齐
 
 @param spacing 图片与文字的间距
 @param bottomPadding 文字距离底部的间距
 */
- (void)xl_alignVerticalWithSpacing:(CGFloat)spacing bottomPadding:(CGFloat)bottomPadding;

/**
 * @brief 设置按钮的图片和文字居中垂直对齐
 * @param spacing 图片与文字的间距
 */
- (void)xl_alignVerticalWithSpacing:(CGFloat)spacing;

/**
 * @brief 设置按钮的图片和文字居中水平对齐
 * @param spacing 图片与文字的间距
 */
- (void)xl_alignHorizontalWithSpacing:(CGFloat)spacing;

/**
 * @brief 设置指定范围内的按钮文字颜色
 * @param color 颜色
 * @param range 范围
 */
- (void)xl_setTitleColor:(UIColor *)color range:(NSRange)range;
@end
