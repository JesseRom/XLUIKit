//
//  UIView+XLRect.h
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  提供位置的基本操作, 方便设置
 */
@interface UIView (XLRect)
/**
 *  frame.origin
 */
@property (nonatomic, assign) CGPoint xl_origin;

/**
 *  frame.size
 */
@property (nonatomic, assign) CGSize  xl_size;

/**
 *  frame.origin.y
 */
@property (nonatomic, assign) CGFloat xl_top;

/**
 *  frame.origin.x
 */
@property (nonatomic, assign) CGFloat xl_left;

/**
 *  frame.origin.y + frame.size.height
 */
@property (nonatomic, assign) CGFloat xl_bottom;

/**
 *  frame.origin.x + frame.size.width
 */
@property (nonatomic, assign) CGFloat xl_right;

/**
 *  frame.size.width
 */
@property (nonatomic, assign) CGFloat xl_width;

/**
 *  frame.size.height
 */
@property (nonatomic, assign) CGFloat xl_height;

/**
 *  center.x
 */
@property (nonatomic, assign) CGFloat xl_centerX;

/**
 *  center.y
 */
@property (nonatomic, assign) CGFloat xl_centerY;

/**
 * middle x
 */
@property (nonatomic, assign) CGFloat xl_midX;

/**
 * middle y
 */
@property (nonatomic, assign) CGFloat xl_midY;

- (void)xl_addCenteredSubview:(UIView *)subview;
- (void)xl_moveToCenterOfSuperview;
- (void)xl_centerVerticallyInSuperview;
- (void)xl_centerHorizontallyInSuperview;
@end
