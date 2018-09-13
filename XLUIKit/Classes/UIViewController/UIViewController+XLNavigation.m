//
//  UIViewController+XLNavigation.m
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/13.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "UIViewController+XLNavigation.h"

@implementation UIViewController (XLNavigation)
#pragma mark - storyboard

+ (instancetype)xl_instantiateFromMainStoryboard {
    
    return [self xl_instantiateFromStoryboardWithName:@"Main" bundle:nil indentifier:NSStringFromClass([self class])];
}

+ (instancetype)xl_instantiateFromStoryboardWithName:(NSString *)name {
    
    return  [self xl_instantiateFromStoryboardWithName:name bundle:nil indentifier:NSStringFromClass([self class])];
}

+ (instancetype)xl_instantiateFromStoryboardWithName:(NSString *)name bundle:(NSBundle *)bundle indentifier:(NSString *)indentifier {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:bundle];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:indentifier];
    return controller;
}

#pragma mark - push

+ (void)xl_pushInNavigationController:(UINavigationController *)navVc fromStoryboard:(NSString *)storyboardName {
    UIViewController *controller = [self xl_instantiateFromStoryboardWithName:storyboardName];
    [navVc pushViewController:controller animated:YES];
}

+ (void)xl_pushInNavigationController:(UINavigationController *)navVc {
    UIViewController *controller = [[self alloc] init];
    [navVc pushViewController:controller animated:YES];
}

+ (void)xl_pushInNavigationController:(UINavigationController *)navVc animated:(BOOL)animated {
    UIViewController *controller = [[self alloc] init];
    [navVc pushViewController:controller animated:animated];
}

#pragma mark - present

- (void)xl_present:(__kindof UIViewController *)viewControllerToPresent fromStoryboard:(NSString *)storyboardName inNavigationController:(__kindof UINavigationController *)navigationController {
    UIViewController *vc = [viewControllerToPresent xl_instantiateFromStoryboardWithName:storyboardName];
    UINavigationController *navigation = [navigationController initWithRootViewController:vc];
    [self presentViewController:navigation animated:YES completion:nil];
}

- (void)xl_present:(__kindof UIViewController *)viewControllerToPresent inNavigationController:(__kindof UINavigationController *)navigationController {
    UIViewController *vc = [[viewControllerToPresent alloc] init];
    UINavigationController *navigation = [navigationController initWithRootViewController:vc];
    [self presentViewController:navigation animated:YES completion:nil];
}

#pragma mark - navigatoin

- (void)xl_pushViewController:(UIViewController *)vc backToNode:(NSArray *)nodeClasses
{
    [self xl_pushViewController:vc backToNode:nodeClasses options:NSEnumerationConcurrent];
}

- (void)xl_pushViewController:(UIViewController *)vc backToNode:(NSArray *)nodeClasses options:(NSEnumerationOptions)options
{
    NSMutableArray *viewControllers = [self.navigationController.viewControllers mutableCopy];
    NSInteger index = [viewControllers indexOfObjectWithOptions:options passingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        
        for (Class class in nodeClasses) {
            if ([obj isKindOfClass:class]) {
                *stop = YES;
                break;
            }
        }
        
        return *stop;
    }];
    
    if (index != NSNotFound && index < viewControllers.count - 1) {
        [viewControllers removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index + 1, viewControllers.count - index - 1)]];
    }
    [viewControllers addObject:vc];
    [self.navigationController setViewControllers:viewControllers animated:YES];
}

- (void)xl_popToNode:(NSArray *)nodeClasses
{
    [self xl_popToNode:nodeClasses options:NSEnumerationConcurrent];
}

- (void)xl_popToNode:(NSArray *)nodeClasses options:(NSEnumerationOptions)options
{
    NSArray *viewControllers = self.navigationController.viewControllers;
    NSUInteger index = [viewControllers indexOfObjectWithOptions:options passingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        
        for (Class class in nodeClasses) {
            if ([obj isKindOfClass:class]) {
                *stop = YES;
                break;
            }
        }
        
        return *stop;
    }];
    
    if (index != NSNotFound && index < viewControllers.count - 1) {
        UIViewController *vc = viewControllers[index];
        [self.navigationController popToViewController:vc animated:YES];
    }
}

- (void)xl_popAndPushViewController:(UIViewController *)vc {
    [self xl_popAndPushViewController:vc animated:YES];
}

- (void)xl_popAndPushViewController:(UIViewController *)vc animated:(BOOL)animated {
    // 将当前 ViewController 弹出，并 push vc
    NSMutableArray *viewControllers = [self.navigationController.viewControllers mutableCopy];
    [viewControllers removeObject:self];
    [viewControllers addObject:vc];
    [self.navigationController setViewControllers:viewControllers animated:animated];
}


- (UIViewController *)xl_rePushPreviousNodeIfExist:(Class)vcNode
{
    NSMutableArray *viewControllers = [self.navigationController.viewControllers mutableCopy];
    NSInteger index = [viewControllers indexOfObjectWithOptions:NSEnumerationReverse passingTest:^BOOL(UIViewController *obj, NSUInteger idx, BOOL *stop) {
        if (idx == viewControllers.count - 2 && [obj isKindOfClass:vcNode]) {
            *stop = YES;
            return YES;
        }
        
        if (idx < viewControllers.count - 2) {
            *stop = YES;
        }
        return NO;
    }];
    
    if (index != NSNotFound && index < viewControllers.count - 1) {
        [viewControllers removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index + 1, viewControllers.count - index - 1)]];
        [self.navigationController setViewControllers:viewControllers animated:YES];
        return viewControllers.lastObject;
    }
    
    return nil;
}
@end
