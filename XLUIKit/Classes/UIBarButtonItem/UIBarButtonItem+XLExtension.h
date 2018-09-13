//
//  UIBarButtonItem+XLExtension.h
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XLExtension)

#pragma mark - title

//Designated Initializer
+ (UIBarButtonItem *)xl_plainBarButtonItemWithTitle:(NSString *)title
                                           tintColor:(UIColor *)tintColor
                                             handler:(void (^)(id sender))action;

//convenience
+ (UIBarButtonItem *)xl_cancelBarButtonItemWithTitle:(NSString *)title handler:(void (^)(id sender))action;
+ (UIBarButtonItem *)xl_backBarButtonItemWithTitle:(NSString *)title
                                            handler:(void (^)(id sender))action;
+ (UIBarButtonItem *)xl_closeBarButtonItemWithHandler:(void (^)(id sender))action;
+ (UIBarButtonItem *)xl_darkCloseBarButtonItemWithHandler:(void (^)(id sender))action;
+ (UIBarButtonItem *)xl_plainBarButtonItemWithTitle:(NSString *)title
                                             handler:(void (^)(id sender))action;
+ (UIBarButtonItem *)xl_plainBarButtonItemWithNormalTitle:(NSString *)normalTitle
                                             selectedTitle:(NSString *)selectedTitle
                                                   handler:(void (^)(id sender))action;
+ (UIBarButtonItem *)xl_doneBarButtonItemWithTitle:(NSString *)title
                                            handler:(void (^)(id sender))action;

#pragma mark - image

//Designated Initializer
+ (UIBarButtonItem *)xl_barButtonItemWithImage:(UIImage *)image
                                        padding:(CGFloat)padding
                                        handler:(void (^)(id sender))action;

//convenience
+ (UIBarButtonItem *)xl_barButtonItemWithImage:(UIImage *)image
                                        handler:(void (^)(id sender))action;


#pragma mark - title & image
+ (UIBarButtonItem *)xl_barButtonItemWithTitle:(NSString *)title
                                          image:(UIImage *)image
                                        handler:(void (^)(id sender))action;
+ (UIBarButtonItem *)xl_barButtonItemWithNormalTitle:(NSString *)normalTitle
                                        selectedTitle:(NSString *)selectedTitle
                                            tintColor:(UIColor *)color
                                                image:(UIImage *)image
                                              handler:(void (^)(id sender))action;
+ (UIBarButtonItem *)xl_barButtonItemWithTitle:(NSString *)title
                                      tintColor:(UIColor *)color
                                          image:(UIImage *)image
                                        handler:(void (^)(id sender))action;

#pragma mark - badge

+ (UIBarButtonItem *)xl_badgeBarButtonItemWithImage:(UIImage *)image
                                             handler:(void (^)(id sender))action;
+ (UIBarButtonItem *)xl_badgeBarButtonItemWithImage:(UIImage *)image
                                             padding:(CGFloat)padding
                                             handler:(void (^)(id sender))action;
- (void)xl_setBadge:(NSInteger)badge;
@end
