//
//  NSString+Compare.m
//  XLFoundation
//
//  Created by HONGLUO on 2018/8/5.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "NSString+Compare.h"

@implementation NSString(Compare)

- (BOOL)mzd_isLargerThan:(NSString *)str {
    NSComparisonResult result = [self compare:str];
    return (result == NSOrderedDescending);
}

- (BOOL)mzd_isLargerOrEqualThan:(NSString *)str {
    NSComparisonResult result = [self compare:str];
    return (result != NSOrderedAscending);
}

@end
