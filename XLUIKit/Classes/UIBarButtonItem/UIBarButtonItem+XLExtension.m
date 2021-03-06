//
//  UIBarButtonItem+XLExtension.m
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "UIBarButtonItem+XLExtension.h"
#import <objc/runtime.h>
#import "UIImage+XLUIKit.h"
#import "UIColor+XLExtension.h"

#pragma mark - BKControlWrapper

@interface BKControlWrapper : NSObject <NSCopying>

- (id)initWithHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents;

@property (nonatomic) UIControlEvents controlEvents;
@property (nonatomic, copy) void (^handler)(id sender);

@end

@implementation BKControlWrapper

- (id)initWithHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents
{
    self = [super init];
    if (!self) return nil;
    
    self.handler = handler;
    self.controlEvents = controlEvents;
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    return [[BKControlWrapper alloc] initWithHandler:self.handler forControlEvents:self.controlEvents];
}

- (void)invoke:(id)sender
{
    self.handler(sender);
}

@end

#pragma mark  - UIControl

static const void *BKControlHandlersKey = &BKControlHandlersKey;

@implementation UIControl (BlocksKit)

- (void)bk_addEventHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents
{
    NSParameterAssert(handler);
    
    NSMutableDictionary *events = objc_getAssociatedObject(self, BKControlHandlersKey);
    if (!events) {
        events = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, BKControlHandlersKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    NSNumber *key = @(controlEvents);
    NSMutableSet *handlers = events[key];
    if (!handlers) {
        handlers = [NSMutableSet set];
        events[key] = handlers;
    }
    
    BKControlWrapper *target = [[BKControlWrapper alloc] initWithHandler:handler forControlEvents:controlEvents];
    [handlers addObject:target];
    [self addTarget:target action:@selector(invoke:) forControlEvents:controlEvents];
}

@end

#pragma mark - XLButton

typedef NS_ENUM(NSInteger, XLButtonImagePosition) {
    XLButtonImagePositionLeft = 0,
    XLButtonImagePositionRight
};

@interface XLButton : UIButton
@property (nonatomic, assign) XLButtonImagePosition imagePosition;
@end

@implementation XLButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imagePosition == XLButtonImagePositionLeft) return;
    
    CGRect imageFrame = self.imageView.frame;
    CGRect labelFrame = self.titleLabel.frame;
    
    labelFrame.origin.x = imageFrame.origin.x - self.imageEdgeInsets.left + self.imageEdgeInsets.right;
    imageFrame.origin.x += labelFrame.size.width;
    
    self.imageView.frame = imageFrame;
    self.titleLabel.frame = labelFrame;
}

@end

#pragma mark  - UIBarButtonItem

@implementation UIBarButtonItem (XLExtension)
+ (UIBarButtonItem *)xl_cancelBarButtonItemWithTitle:(NSString *)title handler:(void (^)(id sender))action {
    UIColor *tintColor = [UIColor xl_colorWithHex:@"#979797"];
    return [UIBarButtonItem xl_barButtonItemWithTitle:title tintColor:tintColor image:nil handler:action];
}

+ (UIBarButtonItem *)xl_backBarButtonItemWithTitle:(NSString *)title handler:(void (^)(id sender))action {
    UIImage *image = [UIImage xl_imageNamedInXLUIKitBundle:@"nav-bar-dark-back-btn"];
    
    NSString *str = title;
    if (!title) {
        str = @"　";
    } else if (title.length == 0) {
        str = [NSString stringWithFormat:@"%@　", str];
    }
    return [self xl_barButtonItemWithTitle:str image:image handler:action];
}

+ (UIBarButtonItem *)xl_closeBarButtonItemWithHandler:(void (^)(id sender))action {
    return [self xl_darkCloseBarButtonItemWithHandler:action];
}

+ (UIBarButtonItem *)xl_darkCloseBarButtonItemWithHandler:(void (^)(id sender))action {
    UIImage *image = [UIImage xl_imageNamedInXLUIKitBundle:@"nav-bar-dark-close-btn"];
    return [self xl_barButtonItemWithImage:image handler:action];
}

+ (UIBarButtonItem *)xl_plainBarButtonItemWithTitle:(NSString *)title handler:(void (^)(id sender))action {
    return [self xl_barButtonItemWithTitle:title image:nil handler:action];
}

+ (UIBarButtonItem *)xl_plainBarButtonItemWithTitle:(NSString *)title
                                           tintColor:(UIColor *)tintColor
                                             handler:(void (^)(id sender))action {
    return [self xl_barButtonItemWithTitle:title tintColor:tintColor image:nil handler:action];
}

+ (UIBarButtonItem *)xl_plainBarButtonItemWithNormalTitle:(NSString *)normalTitle
                                             selectedTitle:(NSString *)selectedTitle
                                                   handler:(void (^)(id sender))action {
    UIColor *tintColor = [UIColor xl_colorWithHex:@"#333333"];
    return [self xl_barButtonItemWithNormalTitle:normalTitle
                                    selectedTitle:selectedTitle
                                        tintColor:tintColor
                                            image:nil
                                          handler:action];
}

+ (UIBarButtonItem *)xl_doneBarButtonItemWithTitle:(NSString *)title handler:(void (^)(id sender))action {
    return [self xl_plainBarButtonItemWithTitle:title handler:action];
}

#pragma mark -

+ (UIBarButtonItem *)xl_barButtonItemWithImage:(UIImage *)image handler:(void (^)(id sender))action {
    return [self xl_barButtonItemWithImage:image padding:0.0 handler:action];
}

+ (UIBarButtonItem *)xl_barButtonItemWithImage:(UIImage *)image
                                        padding:(CGFloat)padding
                                        handler:(void (^)(id sender))action {
    XLButton *button = [XLButton buttonWithType:UIButtonTypeCustom];
    button.frame                     = CGRectMake(0, 0, image.size.width + 2 * padding, image.size.height + padding);
    button.showsTouchWhenHighlighted = YES;
    [button setImage:image forState:UIControlStateNormal];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    __weak typeof(barButtonItem) weakItem = barButtonItem;
    [button bk_addEventHandler:^(id sender) {
        if (action) {
            action(weakItem);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    return barButtonItem;
}

+ (UIBarButtonItem *)xl_barButtonItemWithTitle:(NSString *)title image:(UIImage *)image handler:(void (^)(id sender))action {
    UIColor *tintColor = [UIColor xl_colorWithHex:@"#333333"];
    return [UIBarButtonItem xl_barButtonItemWithTitle:title tintColor:tintColor image:image handler:action];
}

+ (UIBarButtonItem *)xl_barButtonItemWithNormalTitle:(NSString *)normalTitle
                                        selectedTitle:(NSString *)selectedTitle
                                            tintColor:(UIColor *)color
                                                image:(UIImage *)image
                                              handler:(void (^)(id sender))action {
    UIBarButtonItem *item       = [self xl_barButtonItemWithImage:image handler:action];
    UIButton        *customView = [item customView];
    [customView setTitle:normalTitle forState:UIControlStateNormal];
    [customView setTitle:selectedTitle forState:UIControlStateSelected];
    [customView setTitleColor:color forState:UIControlStateNormal];
    [customView setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5] forState:UIControlStateDisabled];
    customView.titleLabel.font = [UIFont systemFontOfSize:16.0];
    CGSize labelSize = [normalTitle sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16.0]}];
    
    CGRect frame = customView.frame;
    frame.size = CGSizeMake(labelSize.width, labelSize.height + 10.0);
    customView.frame = frame;
    
    return item;
}

+ (UIBarButtonItem *)xl_barButtonItemWithTitle:(NSString *)title
                                      tintColor:(UIColor *)color
                                          image:(UIImage *)image
                                        handler:(void (^)(id sender))action {
    UIBarButtonItem *item = [self xl_barButtonItemWithImage:image handler:action];
    if (title.length == 0) {
        return item;
    }
    
    UIButton *customView = [item customView];
    [customView setTitle:title forState:UIControlStateNormal];
    [customView setTitleColor:color forState:UIControlStateNormal];
    [customView setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5] forState:UIControlStateDisabled];
    customView.titleLabel.font = [UIFont systemFontOfSize:16.0];
    
    CGSize labelSize = [title sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16.0]}];
    CGRect frame = customView.frame;
    if (image) {
        frame.size = CGSizeMake(labelSize.width + image.size.width + 5.0, MAX(labelSize.height, image.size.height) + 10.0);
        customView.frame = frame;
        
        customView.titleEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, -5.0);
        customView.imageEdgeInsets = UIEdgeInsetsMake(0.0, -5.0, 0.0, 0.0);
    } else {
        frame.size = CGSizeMake(labelSize.width, labelSize.height + 10.0);
        customView.frame = frame;
    }
    
    return item;
}

#pragma mark - badge

+ (UIBarButtonItem *)xl_badgeBarButtonItemWithImage:(UIImage *)image handler:(void (^)(id sender))action {
    return [self xl_badgeBarButtonItemWithImage:image padding:10.0 handler:action];
}

+ (UIBarButtonItem *)xl_badgeBarButtonItemWithImage:(UIImage *)image
                                             padding:(CGFloat)padding
                                             handler:(void (^)(id sender))action; {
    UIBarButtonItem *item       = [self xl_barButtonItemWithImage:image padding:padding handler:action];
    UIButton        *customView = [item customView];
    
    UIButton *badgeButton = [[UIButton alloc] init];
    
    CGRect frame = badgeButton.frame;
    frame.size = CGSizeMake(18.0, 18.0);
    badgeButton.frame       = frame;
    
    badgeButton.center          = CGPointMake(customView.frame.size.width - padding, 0.0);
    badgeButton.backgroundColor = [UIColor xl_colorWithHex:@"#f43541"];
    [badgeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    badgeButton.layer.cornerRadius     = 9.0;
    badgeButton.clipsToBounds          = YES;
    badgeButton.userInteractionEnabled = NO;
    badgeButton.titleLabel.font        = [UIFont boldSystemFontOfSize:12];
    badgeButton.hidden                 = YES;
    badgeButton.tag                    = 3001;
    
    [customView addSubview:badgeButton];
    return item;
}

- (void)xl_setBadge:(NSInteger)badge {
    UIButton *customView  = [self customView];
    CGFloat  padding      = ceilf((customView.frame.size.width - [customView imageForState:UIControlStateNormal].size.width) / 2.0);
    UIButton *badgeButton = [customView viewWithTag:3001];
    
    if (badge > 0) {
        NSString *badgeString;
        if (badge > 99) {
            badgeString = @"99+";
        } else {
            badgeString = [NSString stringWithFormat:@"%ld", (long) badge];
        }
        
        CGFloat width = [self __suitableWidthWithText:badgeString font:badgeButton.titleLabel.font height:badgeButton.frame.size.height] + 10.0;
        width = MAX(18.0, width);
        
        CGRect frame = badgeButton.frame;
        frame.size = CGSizeMake(width, badgeButton.frame.size.height);
        badgeButton.frame = frame;
        badgeButton.center    = CGPointMake(customView.frame.size.width - padding, ceilf(padding / 2.0));
        
        [badgeButton setTitle:badgeString forState:UIControlStateNormal];
        badgeButton.hidden = NO;
    } else {
        badgeButton.hidden = YES;
    }
}

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
