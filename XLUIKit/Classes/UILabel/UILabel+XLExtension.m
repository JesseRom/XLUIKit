//
//  UILabel+XLExtension.m
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "UILabel+XLExtension.h"
#import <XLFoundation/NSMutableAttributedString+Format.h>

@implementation UILabel (XLExtension)
- (void)xl_setTextColor:(UIColor *)color range:(NSRange)range
{
    if (!self.text) {
        return;
    }
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attributedText addAttribute:NSForegroundColorAttributeName value:color range:range];
    self.attributedText = attributedText;
}

- (void)xl_setKeywordColor:(UIColor *)color keywork:(NSString *)keyword
{
    if (!keyword) {
        return;
    }
    
    NSRange range = [self.text rangeOfString:keyword];
    [self xl_setTextColor:color range:range];
}

- (void)xl_setLineSpacing:(CGFloat)space {
    if (!self.text) {
        return;
    }
    NSTextAlignment alignment = self.textAlignment;
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.text.length)];
    self.attributedText = attributedText;
    self.textAlignment = alignment;
}

- (void)xl_setLineHeightMultiple:(CGFloat)lineHeightMultiple
{
    NSTextAlignment alignment = self.textAlignment;
    NSMutableAttributedString *attributedString = [self.attributedText mutableCopy];
    NSMutableParagraphStyle *paragrahStyle = [NSMutableParagraphStyle new];
    paragrahStyle.lineHeightMultiple = lineHeightMultiple;
    paragrahStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragrahStyle
                             range:NSMakeRange(0, attributedString.length)];
    
    [self setAttributedText:attributedString];
    self.textAlignment = alignment;
}

- (void)xl_strikethrough {
    self.attributedText = [NSMutableAttributedString xl_strikethroughWithText:self.text];
}
@end
