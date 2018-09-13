//
//  NSString+XLExtension.h
//  XLFoundation
//
//  Created by HONGLUO on 2018/8/5.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString(XLExtension)

+ (NSString *)xl_parseString:(NSString*)string separatorIndexs:(NSArray *)indexs separator:(NSString *)separator;
- (CGFloat)xl_fitsWidthWithFont:(UIFont *)font height:(CGFloat)height;
- (CGFloat)xl_fitsHeightWithFont:(UIFont *)font width:(CGFloat)width;
- (CGFloat)xl_fitsHeightWithFont:(UIFont *)font size:(CGSize)size;
+ (NSString *)xl_zodiacSignWithMonth:(NSInteger)month day:(NSInteger)day;
+ (NSString *)xl_zodiacSignWithTs:(NSTimeInterval)ts;

@end
