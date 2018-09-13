//
//  UIApplication+XLBar.m
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "UIApplication+XLBar.h"
#import "UIApplication+XLExtension.h"

@implementation UIApplication(XLBar)

- (CGFloat)xl_topBarHeight {
    UINavigationController *navVc = [[UIApplication sharedApplication] xl_mostTopViewController].navigationController;
    CGFloat height = 0.0;
    if (navVc.navigationBar) {
        CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        height = navVc.navigationBar.frame.size.height + statusBarHeight;
    }
    return height;
}

- (CGFloat)xl_topBarHeightForStickyStatusBar {
    UINavigationController *navVc = [[UIApplication sharedApplication] xl_mostTopViewController].navigationController;
    CGFloat height = 0.0;
    if (navVc.navigationBar) {
        CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        if (statusBarHeight == 0.0) {
            statusBarHeight = 20.0;
        }
        height = navVc.navigationBar.frame.size.height + statusBarHeight;
    }
    return height;
}

+ (CGFloat)xl_topBarHeight {
    return [[self sharedApplication] xl_topBarHeight];
}

+ (CGFloat)topBarHeightForStickyStatusBar {
    return [[self sharedApplication] xl_topBarHeightForStickyStatusBar];
}

- (BOOL)xl_usesViewControllerBasedStatusBarAppearance {
    NSString *key = @"UIViewControllerBasedStatusBarAppearance";
    id object = [[NSBundle mainBundle] objectForInfoDictionaryKey:key];
    return (object != nil);
}

- (void)xl_updateStatusBarAppearanceHidden:(BOOL)hidden animation:(UIStatusBarAnimation)animation fromViewController:(UIViewController *)sender {
    if ([self xl_usesViewControllerBasedStatusBarAppearance]) {
        [sender setNeedsStatusBarAppearanceUpdate];
    } else {
        if (@available(iOS 9, *)) {
            NSLog(@"setStatusBarHidden:withAnimation: is deprecated. Please use view-controller-based status bar appearance.");
        } else {
            [[UIApplication sharedApplication] setStatusBarHidden:hidden withAnimation:animation];
        }
        [[UIApplication sharedApplication] setStatusBarHidden:hidden withAnimation:animation];
    }
}

@end
