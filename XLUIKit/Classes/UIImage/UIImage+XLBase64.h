//
//  UIImage+XLBase64.h
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (XLBase64)
- (NSString *)xl_base64DataString;
+ (UIImage *)xl_imageFromBase64EncodedString:(NSString *)base64String;
@end
