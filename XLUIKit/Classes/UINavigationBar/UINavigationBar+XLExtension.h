//
//  UINavigationBar+XLExtension.h
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UINavigationBar (XLExtension)
- (void)xl_setBackgroundColor:(UIColor *)backgroundColor;
- (void)xl_setCustomBackgroundColor:(UIColor *)backgroundColor;

- (UIView *)xl_overlay;
- (void)setXl_overlay:(UIView *)overlay;
- (void)xl_reset;
@end

