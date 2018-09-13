//
//  NSString+XLJSON.h
//  XLFoundation
//
//  Created by HONGLUO on 2018/8/5.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(XLJSON)

/**
 *  通过 JSON object 初始化字符串
 *
 *  @param object JSON 对象，NSDictionary 或者 NSArray，子项只支持简单对象
 *
 *  @return 序列化后的 json string，转换失败返回 nil
 */
+ (NSString *)mzd_stringWithJSONObject:(id)object;

/**
 *  将当前 字符串转换成 JSON object
 *
 *  @return 如果当前为 json 字符串，则返回序列化后的 json object，否则返回 nil
 */
- (id)mzd_JSONObject;

@end
