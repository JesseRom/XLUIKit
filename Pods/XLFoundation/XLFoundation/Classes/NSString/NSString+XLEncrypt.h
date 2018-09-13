//
//  NSString+XLEncrypt.h
//  XLFoundation
//
//  Created by HONGLUO on 2018/8/5.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(XLEncrypt) 

/**
 *  计算字符串占用字节数
 *
 *  @return 字节数
 */
- (NSInteger)mzd_bytes;

/**
 *  将 16 进制字符串转换为 10 进制数
 *
 *  @return 10 进制数
 */
- (NSUInteger)mzd_hexValue;

/**
 *  计算所在位置为 filePath 的文件 MD5 值
 */
+ (NSString *)mzd_md5OfFile:(NSString *)filePath;

- (NSString *)mzd_md5;

- (NSString *)mzd_sha1WithKey:(NSString *)key;

@end
