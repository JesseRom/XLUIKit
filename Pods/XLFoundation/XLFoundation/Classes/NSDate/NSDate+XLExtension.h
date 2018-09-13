//
//  NSDate+XLExtension.h
//  XLFoundation
//
//  Created by HONGLUO on 2018/8/2.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate(XLExtension)

/**
 @return 2018年8月2日
 */
- (NSString *)xl_mediumStyleString;

/**
 contain YES return 2018年8月2日 22:53
 contain NO return 22:53
 */
- (NSString *)xl_mediumStyleStringContainDate:(BOOL)contain;

/**
 @return 年龄
 */
- (NSInteger)xl_ageOfBirth;

/**
 @return 星座
 */
- (NSString *)xl_zodiacSign;

@end
