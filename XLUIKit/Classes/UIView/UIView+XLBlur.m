//
//  UIView+XLBlur.m
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/13.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "UIView+XLBlur.h"
#import <objc/runtime.h>

NSString const *blurBackgroundKey = @"blurBackgroundKey";
NSString const *blurVibrancyBackgroundKey = @"blurVibrancyBackgroundKey";
NSString const *blurTintColorKey = @"blurTintColorKey";
NSString const *blurTintColorIntensityKey = @"blurTintColorIntensityKey";
NSString const *blurTintColorLayerKey = @"blurTintColorLayerKey";
NSString const *blurStyleKey = @"blurStyleKey";

@implementation UIView (XLBlur)

@dynamic xl_blurBackground;
@dynamic xl_blurTintColor;
@dynamic xl_blurTintColorIntensity;
@dynamic xl_isBlurred;
@dynamic xl_blurStyle;

#pragma mark - category methods
-(void)xl_enableBlur:(BOOL) enable
{
    if(enable) {
        if(IOS_MAJOR_VERSION>=8) {
            UIVisualEffectView* view = (UIVisualEffectView*)self.xl_blurBackground;
            UIVisualEffectView* vibrancyView = self.xl_blurVibrancyBackground;
            if(!view || !vibrancyView) {
                [self xl_blurBuildBlurAndVibrancyViews];
            }
            
        } else {
            UIToolbar* view = (UIToolbar*)self.xl_blurBackground;
            if(!view) {
                // use UIToolbar
                view = [[UIToolbar alloc] initWithFrame:self.bounds];
                objc_setAssociatedObject(self, &blurBackgroundKey, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            [view setFrame:self.bounds];
            view.clipsToBounds = YES;
            view.translucent = YES;
            
            // add the toolbar layer as sublayer
            [self.layer insertSublayer:view.layer atIndex:0];
        }
        
        //        view.barTintColor = [self.blurTintColor colorWithAlphaComponent:0.4f];
    } else {
        if(IOS_MAJOR_VERSION>=8) {
            if(self.xl_blurBackground) {
                [self.xl_blurBackground removeFromSuperview];
                objc_setAssociatedObject(self, &blurBackgroundKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        } else {
            if(self.xl_blurBackground) {
                [self.xl_blurBackground.layer removeFromSuperlayer];
            }
        }
    }
}

-(void)xl_blurBuildBlurAndVibrancyViews NS_AVAILABLE_IOS(8_0)
{
    UIBlurEffectStyle style = UIBlurEffectStyleDark;
    
    if(self.xl_blurStyle == UIViewBlurExtraLightStyle) {
        style = UIBlurEffectStyleExtraLight;
    } else if(self.xl_blurStyle == UIViewBlurLightStyle) {
        style = UIBlurEffectStyleLight;
    }
    // use UIVisualEffectView
    UIVisualEffectView* view = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:style]];
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    view.frame = self.bounds;
    [self addSubview:view];
    objc_setAssociatedObject(self, &blurBackgroundKey, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // save subviews of existing vibrancy view
    NSArray* subviews = self.xl_blurVibrancyBackground.contentView.subviews;
    
    // create vibrancy view
    UIVisualEffectView* vibrancyView = [[UIVisualEffectView alloc]initWithEffect:[UIVibrancyEffect effectForBlurEffect:(UIBlurEffect*)view.effect]];
    vibrancyView.frame = self.bounds;
    [view.contentView addSubview:vibrancyView];
    view.contentView.backgroundColor = [self.xl_blurTintColor colorWithAlphaComponent:self.xl_blurTintColorIntensity];
    
    // add back subviews to vibrancy view
    if(subviews) {
        for (UIView* v in subviews) {
            [vibrancyView.contentView addSubview:v];
        }
    }
    objc_setAssociatedObject(self, &blurVibrancyBackgroundKey, vibrancyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getters/setters
-(UIColor*)xl_blurTintColor
{
    UIColor* color = objc_getAssociatedObject(self, &blurTintColorKey);
    if(!color) {
        color = [UIColor clearColor];
        objc_setAssociatedObject(self, &blurTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return color;
}

-(void)setxl_blurTintColor:(UIColor *)blurTintColor
{
    objc_setAssociatedObject(self, &blurTintColorKey, blurTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if(IOS_MAJOR_VERSION>=8) {
        ((UIVisualEffectView*)self.xl_blurBackground).contentView.backgroundColor = [blurTintColor colorWithAlphaComponent:self.xl_blurTintColorIntensity];
    } else {
        if(self.xl_blurBackground) {
            UIToolbar *toolbar = ((UIToolbar*)self.xl_blurBackground);
            CALayer *colorLayer = objc_getAssociatedObject(self, &blurTintColorLayerKey);
            if(colorLayer==nil) {
                colorLayer = [CALayer layer];
            } else {
                [colorLayer removeFromSuperlayer];
            }
            
            if(self.xl_blurStyle == UIViewBlurDarkStyle) {
                toolbar.barStyle = UIBarStyleBlackTranslucent;
            } else {
                toolbar.barStyle = UIBarStyleDefault;
            }
            colorLayer.frame = toolbar.frame;
            colorLayer.opacity = (float)(0.5*self.xl_blurTintColorIntensity);
            colorLayer.opaque = NO;
            [toolbar.layer insertSublayer:colorLayer atIndex:1];
            colorLayer.backgroundColor = blurTintColor.CGColor;
            
            objc_setAssociatedObject(self, &blurTintColorLayerKey, colorLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
}

-(UIView*)xl_blurBackground
{
    return objc_getAssociatedObject(self, &blurBackgroundKey);
}

-(UIVisualEffectView*)xl_blurVibrancyBackground NS_AVAILABLE_IOS(8_0)
{
    return objc_getAssociatedObject(self, &blurVibrancyBackgroundKey);
}

-(UIViewBlurStyle)xl_blurStyle
{
    NSNumber* style = objc_getAssociatedObject(self, &blurStyleKey);
    if(!style) {
        style = @0;
    }
    return (UIViewBlurStyle)style.integerValue;
}

-(void)setxl_blurStyle:(UIViewBlurStyle)viewBlurStyle
{
    NSNumber *style = [NSNumber numberWithInteger:viewBlurStyle];
    objc_setAssociatedObject(self, &blurStyleKey, style, OBJC_ASSOCIATION_RETAIN);
    
    if(IOS_MAJOR_VERSION>=8) {
        if(self.xl_blurBackground) {
            [self.xl_blurBackground removeFromSuperview];
            [self xl_blurBuildBlurAndVibrancyViews];
        }
    } else {
        if(self.xl_blurBackground) {
            if(viewBlurStyle == UIViewBlurDarkStyle) {
                ((UIToolbar*)self.xl_blurBackground).barStyle = UIBarStyleBlackTranslucent;
            } else {
                ((UIToolbar*)self.xl_blurBackground).barStyle = UIBarStyleDefault;
            }
        }
    }
}

-(void)setxl_blurTintColorIntensity:(double)blurTintColorIntensity
{
    NSNumber *intensity = [NSNumber numberWithDouble:blurTintColorIntensity];
    objc_setAssociatedObject(self, &blurTintColorIntensityKey, intensity, OBJC_ASSOCIATION_RETAIN);
    
    if(IOS_MAJOR_VERSION<8) {
        if(self.xl_blurBackground) {
            CALayer *colorLayer = objc_getAssociatedObject(self, &blurTintColorLayerKey);
            if(colorLayer) {
                colorLayer.opacity = 0.5f*intensity.floatValue;
            }
        }
    }
}

-(double)xl_blurTintColorIntensity
{
    NSNumber *intensity = objc_getAssociatedObject(self, &blurTintColorIntensityKey);
    if(!intensity) {
        intensity = @0.3;
    }
    return intensity.doubleValue;
}
@end

