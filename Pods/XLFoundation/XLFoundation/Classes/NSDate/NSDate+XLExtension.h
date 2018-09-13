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
- (NSString *)mzd_mediumStyleString;

/**
 contain YES return 2018年8月2日 22:53
 contain NO return 22:53
 */
- (NSString *)mzd_mediumStyleStringContainDate:(BOOL)contain;

/**
 @return 年龄
 */
- (NSInteger)mzd_ageOfBirth;

/**
 @return 星座
 */
- (NSString *)mzd_zodiacSign;

@end
