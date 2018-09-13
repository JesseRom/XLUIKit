//
//  UITextField+XLExtension.h
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 准许输入字符类型
typedef NS_ENUM(NSInteger, XLTextFieldCharsType) {
    XLTextFieldCharsTypeNumeral = 1,      // 只许数字
    XLTextFieldCharsTypeLetter,           // 只许大小写字母
    XLTextFieldCharsTypeIdentityCard,     // 只许身份证（数字加上X和x）
    XLTextFieldCharsTypeNumeralAndLetter, // 只许数字加上大小写字母
    XLTextFieldCharsTypeAllChar,          // 允许输入所有字符
};

@interface UITextField (XLExtension)
- (void)xl_setPlaceholder:(NSString *)placeholder color:(UIColor *)color;
- (void)xl_setPlaceholderColor:(UIColor *)color;

+ (BOOL)xl_textField:(UITextField *)textField
                range:(NSRange)range
               string:(NSString *)string
            charsType:(XLTextFieldCharsType)charsType
            maxLength:(NSInteger)maxLength
      separatorIndexs:(NSArray *)indexs
            separator:(NSString *)separator;

+ (NSString *)xl_parseString:(NSString *)string separatorIndexs:(NSArray *)indexs separator:(NSString *)separator;
@end
