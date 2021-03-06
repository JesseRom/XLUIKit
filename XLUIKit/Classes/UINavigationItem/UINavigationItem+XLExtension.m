//
//  UINavigationItem+XLExtension.m
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "UINavigationItem+XLExtension.h"
#import "UIColor+XLExtension.h"
#import "UIView+XLRect.h"

@implementation UINavigationItem (XLExtension)

- (void)xl_setTitleViewWithText:(NSString *)text {
    [self xl_setTitleViewWithText:text color:[UIColor xl_colorWithHex:@"#333333"]];
}

- (void)xl_setLightColorTitleViewWithText:(NSString *)text
{
    UILabel *titleLabel        = [UILabel new];
    titleLabel.text            = text;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment   = NSTextAlignmentCenter;
    titleLabel.textColor       = [UIColor whiteColor];
    titleLabel.font            = [UIFont systemFontOfSize:17.0];
    [titleLabel sizeToFit];
    
    [self.titleView removeFromSuperview];
    self.titleView = titleLabel;
}

- (void)xl_setTitleViewWithText:(NSString *)text color:(UIColor *)color {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text            = text;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment   = NSTextAlignmentCenter;
    titleLabel.textColor       = color;
    titleLabel.font            = [UIFont boldSystemFontOfSize:17.0];
    [titleLabel sizeToFit];
    
    [self.titleView removeFromSuperview];
    self.titleView = titleLabel;
}

- (void)xl_setTitleViewWithActivityAndText:(NSString *)text
{
    CGFloat textWidth = [self __suitableWidthWithText:text font:[UIFont boldSystemFontOfSize:18] height:44.0];
    
    UIView *view         = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, textWidth + 25.0, 44.0)];
    view.backgroundColor = [UIColor clearColor];
    
    CGRect activityFrame = CGRectMake(0.0, 0.0, 20.0, 20.0);
    UIActivityIndicatorView *activityView =
    [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.frame = activityFrame;
    [view addSubview:activityView];
    
    CGRect titleFrame     = CGRectMake(activityFrame.size.width + 5.0, 0.0, textWidth, 44.0);
    UILabel *title        = [[UILabel alloc] initWithFrame:titleFrame];
    title.text            = text;
    title.font            = [UIFont boldSystemFontOfSize:18.0];
    title.textColor       = [UIColor blackColor];
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment   = NSTextAlignmentRight;
    
    [view addSubview:title];
    [activityView xl_centerVerticallyInSuperview];
    
    [self.titleView removeFromSuperview];
    self.titleView = view;
    
    [activityView startAnimating];
}

- (void)xl_setLightColorTitleViewWithActivityAndText:(NSString *)text
{
    CGFloat textWidth = [self __suitableWidthWithText:text font:[UIFont boldSystemFontOfSize:18] height:44.0];
    
    UIView *view         = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, textWidth + 25.0, 44.0)];
    view.backgroundColor = [UIColor clearColor];
    
    CGRect activityFrame = CGRectMake(0.0, 0.0, 20.0, 20.0);
    UIActivityIndicatorView *activityView =
    [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityView.frame = activityFrame;
    [view addSubview:activityView];
    
    CGRect titleFrame     = CGRectMake(activityFrame.size.width + 5.0, 0.0, textWidth, 44.0);
    UILabel *title        = [[UILabel alloc] initWithFrame:titleFrame];
    title.text            = text;
    title.font            = [UIFont boldSystemFontOfSize:18.0];
    title.textColor       = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment   = NSTextAlignmentRight;
    
    [view addSubview:title];
    [activityView xl_centerVerticallyInSuperview];
    
    [self.titleView removeFromSuperview];
    ;
    self.titleView = view;
    
    [activityView startAnimating];
}

- (void)xl_setupLeftBarButtonItem:(UIBarButtonItem *)barButtonItem {
    UIBarButtonItem *space =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    UIButton *button = [barButtonItem customView];
    if (button.titleLabel.text) {
        space.width = -3;
    } else {
        space.width = 2;
    }
    
    [self setLeftBarButtonItems:[NSArray arrayWithObjects:space, barButtonItem, nil]];
}

- (void)xl_setupRightBarButtonItem:(UIBarButtonItem *)barButtonItem {
    UIBarButtonItem *space =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = -3;
    [self setRightBarButtonItems:[NSArray arrayWithObjects:space, barButtonItem, nil]];
}

- (void)xl_setupBackBarButtonItem:(UIBarButtonItem *)barButtonItem {
    [self xl_setupLeftBarButtonItem:barButtonItem];
}

- (void)xl_setupRightBarButtonItems:(NSArray *)items {
    if (items.count == 0) {
        return;
    }
    
    UIBarButtonItem *space =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = -3;
    
    NSComparator comparator = ^(id obj1, id obj2) {
        return NSOrderedDescending;
    };
    NSArray      *array     = [[items arrayByAddingObject:space] sortedArrayUsingComparator:comparator];
    
    [self setRightBarButtonItems:array];
}

- (void)xl_setupLeftBarButtonItems:(NSArray *)items {
    if (items.count == 0) {
        return;
    }
    
    UIBarButtonItem *space =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = -3;
    
    NSArray *array = [@[space] arrayByAddingObjectsFromArray:items];
    [self setLeftBarButtonItems:array];
}

#pragma mark  - private
- (CGFloat)__suitableWidthWithText:(NSString *)text font:(UIFont *)font height:(CGFloat)height
{
    CGSize constraintSize = CGSizeMake(MAXFLOAT, height);
    CGSize realSize;
    if (!font) {
        font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    }
    NSDictionary *attribute = @{NSFontAttributeName: font};
    realSize                = [text boundingRectWithSize:constraintSize
                                                 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                              attributes:attribute
                                                 context:nil]
    .size;
    return ceilf(realSize.width);
}
@end
