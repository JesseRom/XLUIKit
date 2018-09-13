//
//  NSDictionary+XLExtension.m
//  XLFoundation
//
//  Created by HONGLUO on 2018/8/4.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "NSDictionary+XLExtension.h"

@implementation NSDictionary(XLExtension)

- (NSDictionary *)xl_filterEmptyData
{
    NSMutableDictionary *result = [self mutableCopy];
    [result enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:NSDictionary.class]) {
            result[key] = [obj xl_filterEmptyData];
        } else if ([obj isKindOfClass:NSString.class]) {
            if ([obj isEqualToString:@"<null>"]) {
                result[key] = nil;
            }
        } else if ([obj isKindOfClass:NSNull.class]) {
            result[key] = nil;
        }
    }];
    return result;
}

@end
