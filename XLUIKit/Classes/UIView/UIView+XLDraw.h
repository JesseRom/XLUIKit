//
//  UIView+XLDraw.h
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/13.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (XLDraw)
+ (UIView *)xl_topLine;
+ (UIView *)xl_bottomLineWithOffsetX:(CGFloat)offsetX containerHeight:(CGFloat)height;
- (void)xl_setCircleHollowWithMaskColor:(UIColor *)color radius:(CGFloat)radius center:(CGPoint)center;
- (void)xl_setCenterCircleHollowWithMaskColor:(UIColor *)color radius:(CGFloat)radius;
- (void)xl_setHollowWithMaskColor:(UIColor *)color rect:(CGRect)rect;
- (void)xl_addCycleProgress:(CGFloat)progress color:(UIColor *)color width:(CGFloat)width;
- (void)xl_addClockwiseCycleProgress:(CGFloat)progress color:(UIColor *)color width:(CGFloat)width;
- (void)xl_addCircleLayerWithColor:(UIColor *)color width:(CGFloat)width radius:(CGFloat)radius;
- (void)xl_addRectLayerWithColor:(UIColor *)color width:(CGFloat)width inRect:(CGRect)rect;
@end

@interface UIView (XLDrawRectBlock)
typedef void(^XLDrawRectBlock)(CGRect rect);

// Creates and return a UIView (of frame CGRectZero) with a block that gets called on drawRect.
+ (UIView *)xl_viewWithDrawRectBlock:(XLDrawRectBlock)block;

// Creates and return a UIView with a block that gets called on drawRect.
+ (UIView *)xl_viewWithFrame:(CGRect)frame drawRectBlock:(XLDrawRectBlock)block;
@end
