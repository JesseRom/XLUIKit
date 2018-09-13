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

+ (NSString *)mzd_parseString:(NSString*)string separatorIndexs:(NSArray *)indexs separator:(NSString *)separator;
- (CGFloat)mzd_fitsWidthWithFont:(UIFont *)font height:(CGFloat)height;
- (CGFloat)mzd_fitsHeightWithFont:(UIFont *)font width:(CGFloat)width;
- (CGFloat)mzd_fitsHeightWithFont:(UIFont *)font size:(CGSize)size;
+ (NSString *)mzd_zodiacSignWithMonth:(NSInteger)month day:(NSInteger)day;
+ (NSString *)mzd_zodiacSignWithTs:(NSTimeInterval)ts;

@end
