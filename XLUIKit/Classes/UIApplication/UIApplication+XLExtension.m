//
//  UIApplication+XLExtension.m
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "UIApplication+XLExtension.h"

@implementation UIApplication(XLExtension)

#pragma mark - Top view Controller
- (UIWindow *)xl_visibleKeyWindow {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window) {
        return window;
    } else {
        return [UIApplication sharedApplication].delegate.window;
    }
}

- (UIViewController *)xl_mostTopViewController {
    UIViewController *topController = [self xl_visibleKeyWindow].rootViewController;
    NSAssert(topController != nil, @"The root view controller of keywindow is not existed.");
    return [self __getTopController:topController];
}

- (UIViewController *)__getTopController:(UIViewController *)topController {
    if ([topController isKindOfClass:[UINavigationController class]]) {
        UIViewController *visibleViewController = ((UINavigationController *)topController).visibleViewController;
        if (!visibleViewController) {
            return topController;
        }
        
        if ([visibleViewController isKindOfClass:[UIAlertController class]]) { // skip `UIAlertController`
            UINavigationController *navVc = (UINavigationController *)topController;
            int count = navVc.viewControllers.count;
            return navVc.viewControllers[count - 1];
        }
        return [self __getTopController:visibleViewController];
    } else if ([topController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)topController;
        UIViewController *selectedViewController = tabBarController.selectedViewController;
        if (selectedViewController) {
            return [self __getTopController:selectedViewController];
        } else {
            return tabBarController.viewControllers[0];
        }
    } else { // UIViewController
        UIViewController *topVc = topController;
        UIViewController *presentedViewController = topVc.presentedViewController;
        while (presentedViewController) {
            if ([presentedViewController isKindOfClass:[UIAlertController class]]) { // skip `UIAlertController`
                break;
            }
            topVc = presentedViewController;
            presentedViewController = topVc.presentedViewController;
        }
        return topVc;
    }
}

#pragma mark - Other

- (void)xl_setNetworkActivity:(BOOL)inProgress
{
    // Ensure we're on the main thread
    if ([NSThread isMainThread] == NO) {
        [self performSelectorOnMainThread:@selector(_setNetworkActivityWithNumber:)
                               withObject:[NSNumber numberWithBool:inProgress]
                            waitUntilDone:NO];
        return;
    }
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self
                                                 selector:@selector(_setNetworkActivityIndicatorHidden)
                                                   object:nil];
    
    if (inProgress == YES) {
        if (self.networkActivityIndicatorVisible == NO) {
            self.networkActivityIndicatorVisible = inProgress;
        }
    } else {
        [self performSelector:@selector(_setNetworkActivityIndicatorHidden) withObject:nil afterDelay:0.3];
    }
}

- (BOOL)xl_isPirated
{
    //    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"SignerIdentity"] != nil;
    BOOL cydia         = NO;
    BOOL binBash       = NO;
    NSString *filePath = @"/Applications/Cydia.app";
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        cydia = YES;
    }
    
    FILE *f = fopen("/bin/bash", "r");
    if (f != NULL) {
        binBash = YES;
    }
    fclose(f);
    
    if (cydia || binBash) {
        return YES;
    }
    return NO;
}

@end
