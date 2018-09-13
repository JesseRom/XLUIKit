//
//  NSString+XLValidate.h
//  XLFoundation
//
//  Created by HONGLUO on 2018/8/5.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(XLValidate)

/**
 *  是否是合法的 email 地址
 *
 *  @return email 地址返回 YES，反之 NO
 */
- (BOOL)mzd_isValidEmail;

- (BOOL)mzd_isValidPhone;
- (BOOL)mzd_isValidIDCard;

/**
 *  当前字符串是否只包含了参数中设置的类型，通过正则表达式匹配, 例如：1a2b3c测试，在三个开关都打开下返回 YES；111 只要 decimal 打开就为 YES； 1a2b，需要 decimal 和 letter 打开
 *
 *  @param decimal 数字 0-9
 *  @param letter  字母 a-z A-Z
 *  @param chinese  中文
 *  @param other   自定义正则
 *
 *  @return 当前字符串若只包含参数指定的项，返回 YES；反之 NO
 */
- (BOOL)mzd_isContainDecimal:(BOOL)decimal letter:(BOOL)letter chineseCharacter:(BOOL)chinese other:(NSString *)other;

/**
 * 当前字符串是否全是数字
 * @return 全是数字返回 YES，反之 NO
 */
- (BOOL)mzd_isDecimal;

/**
 * 当前字符串是否是整数
 * @return 是整数返回 YES，反之 NO
 */
- (BOOL)mzd_isInteger;

/**
 * 当前字符串是否全是中文
 * @return 全是中文返回 YES，反之 NO
 */
- (BOOL)mzd_isChineseCharacter;

/**
 * 是否全是空格或换行
 * @return 全是空格或换行返回 YES，反之 NO
 */
- (BOOL)mzd_isBlank;

@end
