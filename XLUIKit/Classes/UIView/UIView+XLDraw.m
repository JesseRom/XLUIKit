//
//  UIView+XLDraw.m
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/13.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "UIView+XLDraw.h"
#import "UIImage+XL.h"
#import <objc/runtime.h>

static NSString *const kProgressLayer = @"kProgressLayer";

@implementation UIView (XLDraw)
+ (UIView *)xl_topLine {
    UIImage *image = [UIImage xl_imageNamedInXLUIKitBundle:@"horizontal-separator-default"];
    CGRect frame =
    CGRectMake(0.0, 0.0, [UIScreen mainScreen].bounds.size.width, ceilf(image.size.height / [UIScreen mainScreen].scale));
    UIImageView *imageView     = [[UIImageView alloc] initWithFrame:frame];
    imageView.backgroundColor  = [UIColor clearColor];
    imageView.image            = [image stretchableImageWithLeftCapWidth:1 topCapHeight:0];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    return imageView;
}

+ (UIView *)xl_bottomLineWithOffsetX:(CGFloat)offsetX containerHeight:(CGFloat)height {
    UIImage *image = [UIImage xl_imageNamedInXLUIKitBundle:@"horizontal-separator-default"];
    CGRect frame   = CGRectMake(offsetX,
                                height - image.size.height,
                                [UIScreen mainScreen].bounds.size.width - offsetX,
                                ceilf(image.size.height / [UIScreen mainScreen].scale));
    UIImageView *imageView     = [[UIImageView alloc] initWithFrame:frame];
    imageView.backgroundColor  = [UIColor clearColor];
    imageView.image            = [image stretchableImageWithLeftCapWidth:1 topCapHeight:0];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    return imageView;
}

- (void)xl_setCircleHollowWithMaskColor:(UIColor *)color radius:(CGFloat)radius center:(CGPoint)center {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path appendPath:[UIBezierPath bezierPathWithRect:self.bounds]];
    [path appendPath:[UIBezierPath bezierPathWithArcCenter:center
                                                    radius:radius
                                                startAngle:0
                                                  endAngle:2 * M_PI
                                                 clockwise:NO]];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path          = path.CGPath;
    shapeLayer.fillRule      = kCAFillRuleEvenOdd;
    shapeLayer.fillColor     = color.CGColor;
    
    self.backgroundColor = [UIColor clearColor];
    [self.layer addSublayer:shapeLayer];
}

- (void)xl_setCenterCircleHollowWithMaskColor:(UIColor *)color radius:(CGFloat)radius {
    [self xl_setCircleHollowWithMaskColor:color
                                    radius:radius
                                    center:CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5)];
}

- (void)xl_setHollowWithMaskColor:(UIColor *)color rect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path appendPath:[UIBezierPath bezierPathWithRect:self.bounds]];
    [path appendPath:[UIBezierPath bezierPathWithRect:rect]];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path          = path.CGPath;
    shapeLayer.fillRule      = kCAFillRuleEvenOdd;
    shapeLayer.fillColor     = color.CGColor;
    
    self.backgroundColor = [UIColor clearColor];
    [self.layer addSublayer:shapeLayer];
}

- (void)xl_addCycleProgress:(CGFloat)progress color:(UIColor *)color width:(CGFloat)width {
    if (self.xl_progressLayer != nil) {
        [self.xl_progressLayer removeFromSuperlayer];
    }
    
    CGPoint center     = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    CGFloat radius     = 0.0;
    radius             = ceilf((self.bounds.size.width - width * 2) * 0.5);
    CGFloat startPoint = -M_PI_2;                       //设置进度条起点位置
    CGFloat endPoint   = -M_PI_2 + M_PI * 2 * progress; //设置进度条终点位置
    
    //环形路径
    CAShapeLayer *progressLayer = [CAShapeLayer layer];
    progressLayer.frame         = self.bounds;
    progressLayer.fillColor     = [[UIColor clearColor] CGColor];            // 填充色为无色
    progressLayer.strokeColor   = [color CGColor];                           // 指定path的渲染颜色
    progressLayer.opacity       = 1;                                         //背景颜色的透明度
    progressLayer.lineWidth     = width * [UIScreen mainScreen].scale * 0.5; //线的宽度
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:radius
                                                    startAngle:startPoint
                                                      endAngle:endPoint
                                                     clockwise:YES];
    progressLayer.path = [path CGPath];
    [self.layer addSublayer:progressLayer];
    
    self.xl_progressLayer = progressLayer;
}

- (void)xl_addClockwiseCycleProgress:(CGFloat)progress color:(UIColor *)color width:(CGFloat)width {
    if (self.xl_progressLayer != nil) {
        [self.xl_progressLayer removeFromSuperlayer];
    }
    
    CGPoint center     = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    CGFloat radius     = 0.0;
    radius             = ceilf((self.bounds.size.width - width * 2) * 0.5);
    CGFloat startPoint = -M_PI_2;                       //设置进度条起点位置
    CGFloat endPoint   = -M_PI_2 + M_PI * 2 * progress; //设置进度条终点位置
    
    //环形路径
    CAShapeLayer *progressLayer = [CAShapeLayer layer];
    progressLayer.frame         = self.bounds;
    progressLayer.fillColor     = [[UIColor clearColor] CGColor];            // 填充色为无色
    progressLayer.strokeColor   = [color CGColor];                           // 指定path的渲染颜色
    progressLayer.opacity       = 1;                                         //背景颜色的透明度
    progressLayer.lineWidth     = width * [UIScreen mainScreen].scale * 0.5; //线的宽度
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:radius
                                                    startAngle:endPoint
                                                      endAngle:startPoint
                                                     clockwise:YES];
    progressLayer.path = [path CGPath];
    [self.layer addSublayer:progressLayer];
    
    self.xl_progressLayer = progressLayer;
}

- (void)xl_addCircleLayerWithColor:(UIColor *)color width:(CGFloat)width radius:(CGFloat)radius {
    if (self.xl_progressLayer != nil) {
        [self.xl_progressLayer removeFromSuperlayer];
    }
    
    CGPoint center     = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    CGFloat startPoint = -M_PI_2;            //设置进度条起点位置
    CGFloat endPoint   = -M_PI_2 + M_PI * 2; //设置进度条终点位置
    
    //环形路径
    CAShapeLayer *progressLayer = [CAShapeLayer layer];
    progressLayer.frame         = self.bounds;
    progressLayer.fillColor     = [[UIColor clearColor] CGColor];            // 填充色为无色
    progressLayer.strokeColor   = [color CGColor];                           // 指定path的渲染颜色
    progressLayer.opacity       = 1;                                         //背景颜色的透明度
    progressLayer.lineWidth     = width * [UIScreen mainScreen].scale * 0.5; //线的宽度
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:radius
                                                    startAngle:startPoint
                                                      endAngle:endPoint
                                                     clockwise:YES];
    progressLayer.path = [path CGPath];
    [self.layer addSublayer:progressLayer];
    
    self.xl_progressLayer = progressLayer;
}

- (void)xl_addRectLayerWithColor:(UIColor *)color width:(CGFloat)width inRect:(CGRect)rect {
    if (self.xl_progressLayer != nil) {
        [self.xl_progressLayer removeFromSuperlayer];
    }
    
    // 路径
    CAShapeLayer *progressLayer = [CAShapeLayer layer];
    progressLayer.frame         = self.bounds;
    progressLayer.fillColor     = [[UIColor clearColor] CGColor];            // 填充色为无色
    progressLayer.strokeColor   = [color CGColor];                           // 指定path的渲染颜色
    progressLayer.opacity       = 1;                                         //背景颜色的透明度
    progressLayer.lineWidth     = width * [UIScreen mainScreen].scale * 0.5; //线的宽度
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    progressLayer.path = [path CGPath];
    [self.layer addSublayer:progressLayer];
    
    self.xl_progressLayer = progressLayer;
}

- (void)setXl_progressLayer:(CAShapeLayer *)progressLayer
{
    objc_setAssociatedObject(self, &kProgressLayer, progressLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CAShapeLayer *)xl_progressLayer
{
    return (CAShapeLayer *)objc_getAssociatedObject(self, &kProgressLayer);
}
@end

#pragma mark -- XLDrawRectBlock

@interface XLDrawRectBlockView : UIView
@property (nonatomic, copy) XLDrawRectBlock drawRectBlock;
- (void)setDrawRectBlock:(XLDrawRectBlock)drawRectBlock;
@end


@implementation XLDrawRectBlockView

- (void)drawRect:(CGRect)rect
{
    if (self.drawRectBlock) {
        self.drawRectBlock(rect);
    }
}

@end

@implementation UIView (XLDrawRectBlock)

// Creates and return a UIView (of frame CGRectZero) with a block that gets called on drawRect.
+ (UIView *)xl_viewWithDrawRectBlock:(XLDrawRectBlock)block
{
    return [self xl_viewWithFrame:CGRectZero drawRectBlock:block];
}

// Creates and return a UIView with a block that gets called on drawRect.
+ (UIView *)xl_viewWithFrame:(CGRect)frame drawRectBlock:(XLDrawRectBlock)block
{
    XLDrawRectBlockView *view = [[XLDrawRectBlockView alloc] initWithFrame:frame];
    view.drawRectBlock = block;
    
    return view;
}

@end
