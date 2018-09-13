//
//  UIView+XLScreenshot.h
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/13.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (XLScreenshot)
/**
 *  生成 view 屏幕截图
 *
 *  @return 屏幕截图图片
 */
- (UIImage *)xl_screenShot;

/**
 *  生成 view 的 rect 范围内的屏幕截图
 *
 *  @param rect 截图范围
 *
 *  @return 屏幕截图图片
 */
- (UIImage *)xl_screenShotWithRect:(CGRect)rect;
@end
