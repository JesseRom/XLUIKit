//
//  NSString+XLRender.h
//  XLFoundation
//
//  Created by HONGLUO on 2018/8/5.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(XLRender)

/**
 * String by escaping for url argument.
 * @return Encoding url string.
 */
- (NSString *)xl_urlEncode;

/**
 * String by unescaping from url argument.
 * @return Decoding url string.
 */
- (NSString *)xl_urlDecode;

/**
 *  在当前字符串后添加 URL query string，如果当前字符串本身没有 query string，则补上 ‘？’ 连接符，如果当前已经有 query string 则后补上 ‘&’ 连接符
 *
 *  @param queryString url query string，key=value&key2=value2
 *
 *  @return 拼接后的字符串
 */
- (NSString *)xl_URLStringByAppendingQueryString:(NSString *)queryString;

- (NSURL *)xl_URLByAppendingQueryString:(NSString *)queryString;

@end
