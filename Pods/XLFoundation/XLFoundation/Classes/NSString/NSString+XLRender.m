//
//  NSString+XLRender.m
//  XLFoundation
//
//  Created by HONGLUO on 2018/8/5.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "NSString+XLRender.h"

@implementation NSString(XLRender)

- (NSString *)xl_urlEncode {
    // Encode all the reserved characters, per RFC 3986
    // (<http://www.ietf.org/rfc/rfc3986.txt>)
    NSMutableCharacterSet *set = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [set removeCharactersInString:@"!*'();:@&=+$,/?%#[]"];
    return [self stringByAddingPercentEncodingWithAllowedCharacters:set];
}

- (NSString *)xl_urlDecode {
    NSMutableString *resultString = [NSMutableString stringWithString:self];
    [resultString replaceOccurrencesOfString:@"+"
                                  withString:@" "
                                     options:NSLiteralSearch
                                       range:NSMakeRange(0, [resultString length])];
    return [resultString stringByRemovingPercentEncoding];
}

- (NSString *)xl_URLStringByAppendingQueryString:(NSString *)queryString {
    if (queryString.length > 0) {
        return [NSString stringWithFormat:@"%@%@%@", self, [self rangeOfString:@"?"].length > 0 ? @"&" : @"?", queryString];
    }
    return self;
}

- (NSURL *)xl_URLByAppendingQueryString:(NSString *)queryString {
    if (queryString.length > 0) {
        NSString *URLString = [NSString stringWithFormat:@"%@%@%@", self, [self rangeOfString:@"?"].length > 0 ? @"&" : @"?", queryString];
        return [NSURL URLWithString:URLString];
    }
    
    return [NSURL URLWithString:self];
}

@end
