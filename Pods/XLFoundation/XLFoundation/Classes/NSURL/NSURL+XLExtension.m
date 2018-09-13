//
//  NSURL+XLExtension.m
//  XLFoundation
//
//  Created by HONGLUO on 2018/8/5.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "NSURL+XLExtension.h"
#import "NSDictionary+XLURL.h"

@implementation NSURL(XLExtension)

- (NSDictionary *)mzd_parameters
{
    NSString *parametersString = self.query;
    NSArray *array = [parametersString componentsSeparatedByString:@"&"];
    if (array.count > 0) {
        NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
        __block NSArray *kvArray = nil;
        [array enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
            kvArray = [obj componentsSeparatedByString:@"="];
            if (kvArray.count != 2) {
                NSLog(@"Warning: URL parse parameter:%@ -- error: parameters should like key1=value1&key2=value2 followed by URL path...", obj);
            }
            else {
                parametersDic[kvArray[0]] = kvArray[1];
            }
        }];
        return parametersDic;
    }
    return nil;
}

- (NSURL *)mzd_URLByAppendingQueryString:(NSString *)queryString
{
    if (queryString.length > 0) {
        NSString *URLString = [[NSString alloc] initWithFormat:@"%@%@%@", self.absoluteString, self.query ? @"&" : @"?", queryString];
        return [NSURL URLWithString:URLString];
    }
    
    return self;
}

- (NSURL *)mzd_URLByAddQueriesFromDictionary:(NSDictionary *)dictionary {
    NSString *query = [dictionary mzd_joinURLQueries];
    if (query.length > 0) {
        NSURLComponents *comp = [NSURLComponents componentsWithURL:self resolvingAgainstBaseURL:YES];
        if (comp.query.length > 0) {
            comp.query = [comp.query stringByAppendingString:[NSString stringWithFormat:@"&%@", query]];
        } else {
            comp.query = [query copy];
        }
        return [comp URL];
    }
    
    return self;
}

@end
