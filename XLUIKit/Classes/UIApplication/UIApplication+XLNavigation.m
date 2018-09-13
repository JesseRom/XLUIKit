//
//  UIApplication+XLNavigation.m
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "UIApplication+XLNavigation.h"

#import <objc/runtime.h>

static NSString const *kPopTargetViewControllerKey = @"kPopTargetViewControllerKey";
static NSString const *kNeedPopToHomeViewControllerKey = @"kNeedPopToHomeViewControllerKey";

@implementation UIApplication (XLNavigation)
- (BOOL)xl_needPopToHomeViewController {
    id object = objc_getAssociatedObject(self, &kNeedPopToHomeViewControllerKey);
    if (object) {
        return [object boolValue];
    } else {
        return NO;
    }
}

- (void)xl_setNeedPopToHomeViewController:(BOOL)isNeed {
    objc_setAssociatedObject(self, &kNeedPopToHomeViewControllerKey, @(isNeed), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIViewController *)xl_popTargetViewController {
    return objc_getAssociatedObject(self, &kPopTargetViewControllerKey);
}

- (void)xl_setPopTargetViewController:(UIViewController *)controller {
    objc_setAssociatedObject(self, &kPopTargetViewControllerKey, controller, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)xl_closeCurrentViewControllerAnimated:(BOOL)animated {
    UIViewController *target = self.xl_popTargetViewController;
    BOOL isNeed = self.xl_needPopToHomeViewController;
    if (isNeed) {
        [target.navigationController popToRootViewControllerAnimated:YES];
        [self xl_setPopTargetViewController:nil];
        [self xl_setNeedPopToHomeViewController:NO];
    } else {
        [target.navigationController popToViewController:target animated:animated];
        [self xl_setPopTargetViewController:nil];
    }
    [target.navigationController dismissViewControllerAnimated:YES completion:nil];
}
@end
