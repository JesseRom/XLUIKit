//
//  NSMutableAttributedString+Format.m
//  XLFoundation
//
//  Created by HONGLUO on 2018/8/5.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "NSMutableAttributedString+Format.h"
#import <UIKit/UIKit.h>

@implementation NSMutableAttributedString(Format)

+ (instancetype)mzd_strikethroughWithText:(NSString *)text {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text ?: @""];
    NSRange range = NSMakeRange(0, attributedString.length);
    [attributedString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];
    return attributedString;
}

@end
