//
//  NSURL+XLExtension.h
//  XLFoundation
//
//  Created by HONGLUO on 2018/8/5.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL(XLExtension)

/**
 *  将 URL 的 query string，按照 key-value 形式返回
 *
 *  @return 返回 query string 中参数的字典，忽略不以 key=value 存在的参数
 */
- (NSDictionary *)mzd_parameters;

/**
 *  在当前 URL 后添加 URL query string，如果当前字符串本身没有 query string，则补上 ‘？’ 连接符，如果当前已经有 query string 则后补上 ‘&’ 连接符
 *
 *  @param queryString url query string，key=value&key2=value2
 *
 *  @return 拼接后的 NSURL 对象，如果拼接后的字符串不符合 URL 格式，则返回 nil
 */
- (NSURL *)mzd_URLByAppendingQueryString:(NSString *)queryString;

- (NSURL *)mzd_URLByAddQueriesFromDictionary:(NSDictionary *)dictionary;

@end
