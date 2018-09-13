//
//  UINavigationBar+XLExtension.m
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "UINavigationBar+XLExtension.h"
#import <objc/runtime.h>
#import "UIImage+XLCreate.h"

static char overlayKey;
static char underlayKey;

@implementation UINavigationBar (XLExtension)
- (UIView *)xl_overlay {
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setxl_overlay:(UIView *)overlay {
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)xl_underlay {
    return objc_getAssociatedObject(self, &underlayKey);
}

- (void)setxl_Underlay:(UIView *)underlay {
    objc_setAssociatedObject(self, &underlayKey, underlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)xl_setBackgroundColor:(UIColor *)backgroundColor {
    if (!self.translucent && self.shadowImage) {
        [self setBackgroundImage:[UIImage xl_imageWithColor:backgroundColor] forBarMetrics:UIBarMetricsDefault];
    } else {
        [self xl_setCustomBackgroundColor:backgroundColor];
    }
}

- (void)xl_setCustomBackgroundColor:(UIColor *)backgroundColor {
    if (!self.xl_overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self setShadowImage:[UIImage new]];
        self.xl_overlay                        = [[UIView alloc]
                                                   initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.bounds), 64)];
        self.xl_overlay.userInteractionEnabled = NO;
        self.xl_overlay.autoresizingMask       = UIViewAutoresizingFlexibleWidth;
        
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView *obj, NSUInteger idx, BOOL *stop) {
            NSRange range = [NSStringFromClass(obj.class) rangeOfString:@"Background"];
            if (range.length > 0) {
                if (obj.frame.origin.y < 0) {
                    CGRect frame = self.xl_overlay.frame;
                    frame.origin.y = 0;
                    self.xl_overlay.frame = frame;
                }
                [obj addSubview:self.xl_overlay];
                *stop = YES;
            }
        }];
    }
    self.xl_overlay.backgroundColor = backgroundColor;
}

- (void)xl_reset {
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.xl_overlay removeFromSuperview];
    self.xl_overlay = nil;
}
@end
