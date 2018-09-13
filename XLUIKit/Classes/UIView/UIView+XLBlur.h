//
//  UIView+XLBlur.h
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/13.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifndef IOS_MAJOR_VERSION
#define IOS_MAJOR_VERSION (((NSString*)[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."][0]).integerValue)
#endif

#ifndef IOS_MINOR_VERSION
#define IOS_MINOR_VERSION (((NSString*)[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."][1]).integerValue)
#endif


typedef NS_ENUM(NSInteger, UIViewBlurStyle) {
    UIViewBlurExtraLightStyle,
    UIViewBlurLightStyle,
    UIViewBlurDarkStyle
};

@interface UIView (XLBlur)

/* The UIToolbar/UIVisualEffectView(ios8) that has been put on the current view, use it to do your bidding */
@property (strong,nonatomic,readonly) UIView* xl_blurBackground;

/* The UIVisualEffectView that should be used for vibrancy element, add subviews to .contentView */
@property (strong,nonatomic,readonly) UIVisualEffectView* xl_blurVibrancyBackground NS_AVAILABLE_IOS(8_0);

/* tint color of the blurred view */
@property (strong,nonatomic) UIColor* xl_blurTintColor;

/* intensity of blurTintColor applied on the blur 0.0-1.0, default 0.6f */
@property (assign,nonatomic) double xl_blurTintColorIntensity;

/* returns if blurring is enabled */
@property (readonly,nonatomic) BOOL xl_isBlurred;

/* Style of Toolbar, remapped to UIViewBlurStyle typedef above */
@property (assign,nonatomic) UIViewBlurStyle xl_blurStyle;

/* method to enable Blur on current UIView */
-(void)xl_enableBlur:(BOOL) enable;

@end
