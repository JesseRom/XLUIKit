//
//  NSDictionary+XLURL.m
//  XLFoundation
//
//  Created by HONGLUO on 2018/8/4.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "NSDictionary+XLURL.h"

@implementation NSDictionary(XLURL)

- (NSString *)mzd_joinURLQueries
{
    if (self.allKeys.count > 0) {
        NSEnumerator *keyEnumerator = [self keyEnumerator];
        id key                      = [keyEnumerator nextObject];
        NSMutableString *query      = [NSMutableString stringWithFormat:@"%@=%@", key, self[key]];
        while ((key = [keyEnumerator nextObject]) != nil) {
            [query appendFormat:@"&%@=%@", key, self[key]];
        }
        return query;
    }
    return nil;
}

@end
