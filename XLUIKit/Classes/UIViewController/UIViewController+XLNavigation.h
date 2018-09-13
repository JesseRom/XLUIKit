//
//  UIViewController+XLNavigation.h
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/13.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIViewController (XLNavigation)

#pragma mark - storyboard
+ (instancetype)xl_instantiateFromMainStoryboard;
+ (instancetype)xl_instantiateFromStoryboardWithName:(NSString *)name;
+ (instancetype)xl_instantiateFromStoryboardWithName:(NSString *)name bundle:(NSBundle *)bundle indentifier:(NSString *)indentifier;

#pragma mark - push

+ (void)xl_pushInNavigationController:(UINavigationController *)navVc fromStoryboard:(NSString *)storyboardName;
+ (void)xl_pushInNavigationController:(UINavigationController *)navVc;
+ (void)xl_pushInNavigationController:(UINavigationController *)navVc animated:(BOOL)animated;

#pragma mark - present

- (void)xl_present:(__kindof UIViewController *)viewControllerToPresent fromStoryboard:(NSString *)storyboardName inNavigationController:(__kindof UINavigationController *)navigationController;
- (void)xl_present:(__kindof UIViewController *)viewControllerToPresent inNavigationController:(__kindof UINavigationController *)navigationController;

#pragma mark - navigation

- (void)xl_pushViewController:(UIViewController *)vc backToNode:(NSArray *)nodeClasses;
- (void)xl_pushViewController:(UIViewController *)vc backToNode:(NSArray *)nodeClasses options:(NSEnumerationOptions)options;

- (void)xl_popToNode:(NSArray *)nodeClasses;
- (void)xl_popToNode:(NSArray *)nodeClasses options:(NSEnumerationOptions)options;

- (void)xl_popAndPushViewController:(UIViewController *)vc;
- (void)xl_popAndPushViewController:(UIViewController *)vc animated:(BOOL)animated;

- (UIViewController *)xl_rePushPreviousNodeIfExist:(Class)vcNode;
@end
