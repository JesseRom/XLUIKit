//
//  UIView+XLTopToast.h
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/13.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (XLTopToast)
- (void)xl_toastWithMessage:(NSString *)message;
- (void)xl_toastWithMessage:(NSString *)message color:(UIColor *)color;
- (void)xl_toastInfoWithMessage:(NSString *)message onTop:(BOOL)flag;
- (void)xl_toastInfoWithMessage:(NSString *)message;
- (void)xl_hideToast:(UIView *)toast;
@end
