//
//  UILabel+XLExtension.h
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UILabel (XLExtension)
- (void)xl_setKeywordColor:(UIColor *)color keywork:(NSString *)keyword;
- (void)xl_setTextColor:(UIColor *)color range:(NSRange)range;
- (void)xl_setLineSpacing:(CGFloat)space;
- (void)xl_setLineHeightMultiple:(CGFloat)lineHeightMultiple;

- (void)xl_strikethrough;
@end
