//
//  UITextField+XLExtension.m
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "UITextField+XLExtension.h"

@implementation UITextField (XLExtension)
- (void)xl_setPlaceholder:(NSString *)placeholder color:(UIColor *)color
{
    if (color) {
        self.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        self.placeholder = placeholder;
    }
}

- (void)xl_setPlaceholderColor:(UIColor *)color
{
    if (!color) {
        return;
    }
    
    NSDictionary *attributes =
    (NSMutableDictionary *)[(NSAttributedString *)self.attributedPlaceholder attributesAtIndex:0
                                                                                effectiveRange:NULL];
    NSMutableDictionary *newAttributes = [[NSMutableDictionary alloc] initWithDictionary:attributes];
    
    [newAttributes setObject:color forKey:NSForegroundColorAttributeName];
    
    // Set new text with extracted attributes
    if ([self.attributedPlaceholder string]) {
        self.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:[self.attributedPlaceholder string] attributes:newAttributes];
    } else {
        self.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:@"placeholderString" attributes:newAttributes];
        self.placeholder = nil;
    }
}

+ (BOOL)xl_textField:(UITextField *)textField range:(NSRange)range string:(NSString *)string charsType:(XLTextFieldCharsType)charsType maxLength:(NSInteger)maxLength separatorIndexs:(NSArray *)indexs separator:(NSString *)separator {
    
    if ([string isEqualToString:separator]) return NO;
    
    // 添加限制条件,只能输入这个字符串内的字符
    NSString *allowChar;
    switch (charsType) {
        case XLTextFieldCharsTypeNumeral:
            allowChar = @"0123456789\b";
            break;
        case XLTextFieldCharsTypeLetter:
            allowChar = @"qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM\b";
            break;
        case XLTextFieldCharsTypeIdentityCard:
            allowChar = @"0123456789Xx\b";
            break;
        case XLTextFieldCharsTypeNumeralAndLetter:
            allowChar = @"0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM\b";
            break;
        default:
            break;
    }
    
    NSCharacterSet *characterSet;
    if (charsType != XLTextFieldCharsTypeAllChar) {
        characterSet = [NSCharacterSet characterSetWithCharactersInString:allowChar];
        string = [string stringByReplacingOccurrencesOfString:separator withString:@""];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        }
    }
    
    NSString *text = textField.text;
    
    if ([string isEqualToString:@""]){
        if (range.length == 1) {
            if (range.location == text.length - 1) {
                if ([[text substringFromIndex:text.length -1] isEqualToString:separator]) {
                    [textField deleteBackward];
                }
                return YES;
            }
            else {
                NSInteger offset = range.location;
                if (range.location < text.length && [[text substringFromIndex:range.location] isEqualToString:separator] && [textField.selectedTextRange isEmpty]) {
                    [textField deleteBackward];
                    offset --;
                }
                [textField deleteBackward];
                textField.text = [self xl_parseString:textField.text separatorIndexs:indexs separator:separator];
                UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
                textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
                return NO;
            }
        }
        else if (range.length > 1) {
            BOOL isLast = NO;
            if(range.location + range.length == textField.text.length ){
                isLast = YES;
            }
            [textField deleteBackward];
            textField.text = [self xl_parseString:textField.text separatorIndexs:indexs separator:separator];
            
            __block NSInteger offset = range.location;
            [indexs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSInteger index = [obj integerValue];
                if (range.location == index) offset++;
            }];
            
            if (isLast) {
            } else {
                UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
                textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
            }
            return NO;
        }
        else {
            return YES;
        }
    }
    else if (string.length > 0) {
        NSString *str;
        if (charsType != XLTextFieldCharsTypeAllChar) {
            str = [textField.text stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        }
        str = [textField.text stringByReplacingOccurrencesOfString:separator withString:@""];
        
        if ((str.length + string.length - range.length > maxLength) ) {
            return NO;
        }
        
        [textField insertText:string];
        textField.text = [self xl_parseString:textField.text separatorIndexs:indexs separator:separator];
        
        __block NSInteger offset = range.location + string.length;
        [indexs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSInteger index = [obj integerValue];
            if (range.location == index) offset++;
        }];
        UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
        textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
        return NO;
    } else {
        return YES;
    }
}

+ (NSString *)xl_parseString:(NSString*)string separatorIndexs:(NSArray *)indexs separator:(NSString *)separator {
    if (!string) return nil;
    NSMutableString *mStr = [NSMutableString stringWithString:[string stringByReplacingOccurrencesOfString:separator withString:@""]];
    [indexs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger index = [obj integerValue];
        if (mStr.length > index) [mStr insertString:separator atIndex:index];
    }];
    return  mStr;
}
@end
