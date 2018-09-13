//
//  NSLocale+XLExtenstion.m
//  XLFoundation
//
//  Created by HONGLUO on 2018/8/2.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "NSLocale+XLExtenstion.h"

@implementation NSLocale(XLExtenstion)

+ (NSLocale *)mzd_simplifiedChineseLocale {
    static NSLocale *locale = nil;
    
    NSString *localeIdentifier = [NSLocale.currentLocale localeIdentifier];
    localeIdentifier = [localeIdentifier stringByReplacingCharactersInRange:NSMakeRange(0, 2) withString:@"zh-Hans"];
    
    if (!locale || ![localeIdentifier isEqualToString:locale.localeIdentifier]) {
        locale = [[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier];
    }
    return locale;
}

@end
