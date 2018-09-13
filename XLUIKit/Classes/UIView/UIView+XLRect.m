//
//  UIView+XLRect.m
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "UIView+XLRect.h"

@implementation UIView (XLRect)
- (CGPoint)xl_origin
{
    return self.frame.origin;
}

- (void)setxl_origin:(CGPoint)xl_origin
{
    self.frame = CGRectMake(xl_origin.x, xl_origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGSize)xl_size
{
    return self.frame.size;
}

- (void)setxl_size:(CGSize)xl_size
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, xl_size.width, xl_size.height);
}

- (CGFloat)xl_top
{
    return self.frame.origin.y;
}

- (void)setxl_top:(CGFloat)xl_top
{
    self.frame = CGRectMake(self.frame.origin.x, xl_top, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)xl_left
{
    return self.frame.origin.x;
}

- (void)setxl_left:(CGFloat)xl_left
{
    self.frame = CGRectMake(xl_left, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)xl_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setxl_bottom:(CGFloat)xl_bottom
{
    self.frame = CGRectMake(self.frame.origin.x, xl_bottom - self.frame.size.height, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)xl_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setxl_right:(CGFloat)xl_right
{
    self.frame = CGRectMake(xl_right - self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)xl_width
{
    return self.frame.size.width;
}

- (void)setxl_width:(CGFloat)xl_width
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, xl_width, self.frame.size.height);
}

- (CGFloat)xl_height
{
    return self.frame.size.height;
}

- (void)setxl_height:(CGFloat)xl_height
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, xl_height);
}

- (CGFloat)xl_centerX
{
    return self.center.x;
}

- (void)setxl_centerX:(CGFloat)xl_centerX
{
    self.center = CGPointMake(xl_centerX, self.center.y);
}

- (CGFloat)xl_centerY
{
    return self.center.y;
}

- (void)setxl_centerY:(CGFloat)xl_centerY
{
    self.center = CGPointMake(self.center.x, xl_centerY);
}

- (CGFloat)xl_midX
{
    return (CGFloat) (self.frame.origin.x + floor(self.frame.size.width / 2.0));
}

- (void)setxl_midX:(CGFloat)newX
{
    self.frame = CGRectMake((CGFloat) (newX - floor(self.frame.size.width / 2.0)), self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)xl_midY
{
    return (CGFloat) (self.frame.origin.y + floor(self.frame.size.height / 2.0));
}

- (void)setxl_midY:(CGFloat)newY
{
    self.frame = CGRectMake(self.frame.origin.x, (CGFloat) (newY - floor(self.frame.size.height / 2.0)), self.frame.size.width, self.frame.size.height);
}

- (void)xl_addCenteredSubview:(UIView *)subview
{
    subview.xl_left = (CGFloat) floor(((self.bounds.size.width - subview.xl_width) / 2));
    subview.xl_top = (CGFloat) floor(((self.bounds.size.height - subview.xl_height) / 2));
    [self addSubview:subview];
}

- (void)xl_moveToCenterOfSuperview
{
    self.xl_left = (CGFloat) floor(((self.superview.bounds.size.width - self.xl_width) / 2));
    self.xl_top = (CGFloat) floor(((self.superview.bounds.size.height - self.xl_height) / 2));
}

- (void)xl_centerVerticallyInSuperview
{
    self.xl_top = (CGFloat) floor(((self.superview.bounds.size.height - self.xl_height) / 2));
}

- (void)xl_centerHorizontallyInSuperview
{
    self.xl_left = (CGFloat) floor(((self.superview.bounds.size.width - self.xl_width) / 2));
}
@end
