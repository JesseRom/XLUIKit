//
//  UIColor+XLExtension.m
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "UIColor+XLExtension.h"

@implementation NSString (XLHexValue)

- (NSUInteger)xl_hexValue
{
    NSUInteger result = 0;
    sscanf([self UTF8String], "%lx", (unsigned long *)&result);
    return result;
}

@end

@implementation UIColor (XLExtension)
+ (UIColor *)xl_randomColor
{
    return [self xl_randomColor:1.0];
}

+ (UIColor *)xl_randomColor:(CGFloat)alpha
{
    return [UIColor colorWithRed:(((NSInteger)arc4random())       & 0xFF) / 255.0
                           green:(((NSInteger)arc4random() >> 8)  & 0xFF) / 255.0
                            blue:(((NSInteger)arc4random() >> 16) & 0xFF) / 255.0
                           alpha:alpha];
}

+ (UIColor *)xl_colorWithHex:(NSString *)hex
{
    // Remove `#` and `0x`
    if ([hex hasPrefix:@"#"]) {
        hex = [hex substringFromIndex:1];
    } else if ([hex hasPrefix:@"0x"]) {
        hex = [hex substringFromIndex:2];
    }
    
    // Invalid if not 3, 6, or 8 characters
    NSUInteger length = [hex length];
    if (length != 3 && length != 6 && length != 8) {
        return nil;
    }
    
    // Make the string 8 characters long for easier parsing
    if (length == 3) {
        NSString *r = [hex substringWithRange:NSMakeRange(0, 1)];
        NSString *g = [hex substringWithRange:NSMakeRange(1, 1)];
        NSString *b = [hex substringWithRange:NSMakeRange(2, 1)];
        hex = [NSString stringWithFormat:@"%@%@%@%@%@%@ff",
               r, r, g, g, b, b];
    } else if (length == 6) {
        hex = [hex stringByAppendingString:@"ff"];
    }
    
    CGFloat red = [[hex substringWithRange:NSMakeRange(0, 2)] xl_hexValue] / 255.0f;
    CGFloat green = [[hex substringWithRange:NSMakeRange(2, 2)] xl_hexValue] / 255.0f;
    CGFloat blue = [[hex substringWithRange:NSMakeRange(4, 2)] xl_hexValue] / 255.0f;
    CGFloat alpha = [[hex substringWithRange:NSMakeRange(6, 2)] xl_hexValue] / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (NSString *)xl_hexValue
{
    return [self xl_hexValueWithAlpha:NO];
}

- (NSString *)xl_hexValueWithAlpha:(BOOL)includeAlpha
{
    CGColorRef color = self.CGColor;
    size_t count = CGColorGetNumberOfComponents(color);
    const CGFloat *components = CGColorGetComponents(color);
    
    static NSString *stringFormat = @"%02x%02x%02x";
    
    NSString *hex = nil;
    
    // Grayscale
    if (count == 2) {
        NSUInteger white = (NSUInteger)(components[0] * 255.0f);
        hex = [NSString stringWithFormat:stringFormat, white, white, white];
    }
    
    // RGB
    else if (count == 4) {
        hex = [NSString stringWithFormat:stringFormat, (NSUInteger)(components[0] * 255.0f),
               (NSUInteger)(components[1] * 255.0f), (NSUInteger)(components[2] * 255.0f)];
    }
    
    // Add alpha
    if (hex && includeAlpha) {
        hex = [hex stringByAppendingFormat:@"%02lx", (unsigned long)(self.xl_alpha * 255.0f)];
    }
    
    // Unsupported color space
    return hex;
}

- (CGFloat)xl_red
{
    CGColorRef color = self.CGColor;
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color)) != kCGColorSpaceModelRGB) {
        return -1.0f;
    }
    CGFloat const *components = CGColorGetComponents(color);
    return components[0];
}


- (CGFloat)xl_green
{
    CGColorRef color = self.CGColor;
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color)) != kCGColorSpaceModelRGB) {
        return -1.0f;
    }
    CGFloat const *components = CGColorGetComponents(color);
    return components[1];
}

- (CGFloat)xl_blue
{
    CGColorRef color = self.CGColor;
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color)) != kCGColorSpaceModelRGB) {
        return -1.0f;
    }
    CGFloat const *components = CGColorGetComponents(color);
    return components[2];
}

- (CGFloat)xl_alpha
{
    return CGColorGetAlpha(self.CGColor);
}
@end
