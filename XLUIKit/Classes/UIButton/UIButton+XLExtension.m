//
//  UIButton+XLExtension.m
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "UIButton+XLExtension.h"

@implementation UIButton (XLExtension)
- (void)xl_alignVerticalWithSpacing:(CGFloat)spacing bottomPadding:(CGFloat)bottomPadding
{
    CGSize imageSize  = self.imageView.image.size;
    CGSize titleSize  = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}];
    CGSize buttonSize = self.bounds.size;
    
    CGFloat titleBottomOffset = buttonSize.height - titleSize.height - bottomPadding * 2;
    CGFloat imageBottomOffset = buttonSize.height - imageSize.height;
    CGFloat imageTopOffset    = (CGFloat) floor((titleSize.height + bottomPadding + spacing) * 2);
    self.titleEdgeInsets      = UIEdgeInsetsMake(0.0, -imageSize.width, -titleBottomOffset, 0.0);
    self.imageEdgeInsets      = UIEdgeInsetsMake(-imageTopOffset, 0.0, -imageBottomOffset, -titleSize.width);
    
    // increase the content height to avoid clipping
    CGFloat edgeOffset     = (CGFloat) (fabs(titleSize.height - imageSize.height) / 2.0);
    self.contentEdgeInsets = UIEdgeInsetsMake(edgeOffset, 0.0, edgeOffset, 0.0);
}

- (void)xl_alignVerticalWithSpacing:(CGFloat)spacing {
    CGSize imageSize = self.imageView.image.size;
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
    
    CGSize titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}];
    self.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
    
    // increase the content height to avoid clipping
    CGFloat edgeOffset = (CGFloat) (fabsf(titleSize.height - imageSize.height) / 2.0);
    self.contentEdgeInsets = UIEdgeInsetsMake(edgeOffset, 0.0, edgeOffset, 0.0);
}

- (void)xl_alignHorizontalWithSpacing:(CGFloat)spacing {
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
}

- (void)xl_setTitleColor:(UIColor *)color range:(NSRange)range
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self.currentTitle];
    [attrStr setAttributes:@{NSForegroundColorAttributeName: self.currentTitleColor}
                     range:NSMakeRange(0, self.currentTitle.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    [self setAttributedTitle:attrStr forState:UIControlStateNormal];
}
@end
