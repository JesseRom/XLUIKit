//
//  UIScrollView+XLScroll.m
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "UIScrollView+XLScroll.h"

@implementation UIScrollView (XLScroll)
- (void)xl_scrollToTop
{
    [self xl_scrollToTopAnimated:YES];
}

- (void)xl_scrollToTopAnimated:(BOOL)animated
{
    CGPoint offset = self.contentOffset;
    offset.y = 0 - self.contentInset.top;
    [self setContentOffset:offset animated:animated];
}
@end
