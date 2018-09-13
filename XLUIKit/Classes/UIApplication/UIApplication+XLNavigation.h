//
//  UIApplication+XLNavigation.h
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIApplication(XLNavigation)

- (BOOL)xl_needPopToHomeViewController;
- (void)xl_setNeedPopToHomeViewController:(BOOL)isNeed;

- (UIViewController *)xl_popTargetViewController;
- (void)xl_setPopTargetViewController:(UIViewController *)controller;

- (void)xl_closeCurrentViewControllerAnimated:(BOOL)animated;

@end
