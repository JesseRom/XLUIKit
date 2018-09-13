//
//  NSLocale+XLExtension.m
//  XLFoundation
//
//  Created by HONGLUO on 2018/8/2.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "NSLocale+XLExtension.h"

@implementation NSLocale(XLExtension)

+ (NSLocale *)xl_simplifiedChineseLocale {
    static NSLocale *locale = nil;
    
    NSString *localeIdentifier = [NSLocale.currentLocale localeIdentifier];
    localeIdentifier = [localeIdentifier stringByReplacingCharactersInRange:NSMakeRange(0, 2) withString:@"zh-Hans"];
    
    if (!locale || ![localeIdentifier isEqualToString:locale.localeIdentifier]) {
        locale = [[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier];
    }
    return locale;
}

@end
