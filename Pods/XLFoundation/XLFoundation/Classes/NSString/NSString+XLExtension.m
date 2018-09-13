//
//  NSString+XLExtension.m
//  XLFoundation
//
//  Created by HONGLUO on 2018/8/5.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "NSString+XLExtension.h"

@implementation NSString(XLExtension)

+ (NSString *)xl_parseString:(NSString*)string separatorIndexs:(NSArray *)indexs separator:(NSString *)separator {
    if (!string) return nil;
    NSMutableString *mStr = [NSMutableString stringWithString:[string stringByReplacingOccurrencesOfString:separator withString:@""]];
    [indexs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger index = [obj integerValue];
        if (mStr.length > index) [mStr insertString:separator atIndex:index];
    }];
    return  mStr;
}

- (CGFloat)xl_fitsWidthWithFont:(UIFont *)font height:(CGFloat)height
{
    CGSize constraintSize = CGSizeMake(MAXFLOAT, height);
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize realSize = [self boundingRectWithSize:constraintSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return ceilf(realSize.width);
}

- (CGFloat)xl_fitsHeightWithFont:(UIFont *)font width:(CGFloat)width
{
    CGSize constraintSize = CGSizeMake(width, MAXFLOAT);
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize realSize = [self boundingRectWithSize:constraintSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return ceilf(realSize.height);
}

- (CGFloat)xl_fitsHeightWithFont:(UIFont *)font size:(CGSize)size
{
    CGSize realSize;
    NSDictionary *attribute = @{NSFontAttributeName: font};
    realSize                = [self boundingRectWithSize:size
                                                 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                              attributes:attribute
                                                 context:nil].size;
    return ceilf(realSize.height);
}

#pragma mark - 星座
+ (NSString *)xl_zodiacSignWithMonth:(NSInteger)m day:(NSInteger)d
{
    NSString *zodiacString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *zodiacFormat = @"102123444543";
    
    if (m<1||m>12||d<1||d>31){
        return @"";
    }
    
    if(m==2 && d>29) {
        return @"";
    } else if (m==4 || m==6 || m==9 || m==11) {
        if (d>30) {
            return @"";
        }
    }
    
    NSString *result = [NSString stringWithFormat:@"%@座",[zodiacString substringWithRange:NSMakeRange(m*2-(d < [[zodiacFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19))*2,2)]];
    
    return result;
}

+ (NSString *)xl_zodiacSignWithTs:(NSTimeInterval)ts
{
    NSDate *today = [NSDate dateWithTimeIntervalSince1970:ts];
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *weekdayComponents = [gregorian components:(NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:today];
    NSInteger month = [weekdayComponents month];
    NSInteger day = [weekdayComponents day];
    return [NSString xl_zodiacSignWithMonth:month day:day];
}

@end
