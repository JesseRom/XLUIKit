//
//  UIApplication+XLBar.h
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIApplication(XLBar)

- (CGFloat)xl_topBarHeight;
- (CGFloat)xl_topBarHeightForStickyStatusBar;

+ (CGFloat)xl_topBarHeight;
+ (CGFloat)xl_topBarHeightForStickyStatusBar;

- (BOOL)xl_usesViewControllerBasedStatusBarAppearance;
- (void)xl_updateStatusBarAppearanceHidden:(BOOL)hidden animation:(UIStatusBarAnimation)animation fromViewController:(UIViewController *)sender;

@end
