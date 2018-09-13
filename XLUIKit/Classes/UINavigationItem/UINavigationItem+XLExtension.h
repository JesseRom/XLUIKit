//
//  UINavigationItem+XLExtension.h
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UINavigationItem (XLExtension)
- (void)xl_setTitleViewWithText:(NSString *)text;
- (void)xl_setLightColorTitleViewWithText:(NSString *)text;
- (void)xl_setTitleViewWithText:(NSString *)text color:(UIColor *)color;

- (void)xl_setTitleViewWithActivityAndText:(NSString *)text;
- (void)xl_setLightColorTitleViewWithActivityAndText:(NSString *)text;

- (void)xl_setupLeftBarButtonItem:(UIBarButtonItem *)barButtonItem;
- (void)xl_setupRightBarButtonItem:(UIBarButtonItem *)barButtonItem;
- (void)xl_setupBackBarButtonItem:(UIBarButtonItem *)barButtonItem;

- (void)xl_setupRightBarButtonItems:(NSArray *)items;
- (void)xl_setupLeftBarButtonItems:(NSArray *)items;
@end
