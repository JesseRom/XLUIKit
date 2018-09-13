//
//  UIImage+XLBase64.m
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "UIImage+XLBase64.h"

@implementation UIImage (XLBase64)
- (NSString *)xl_base64DataString {
    NSData *imageData = UIImageJPEGRepresentation(self, 0.0);
    NSString *prefix = @"data:image/jpeg;base64,";
    NSString *base64String = [imageData base64EncodedStringWithOptions:0];
    return [prefix stringByAppendingString:base64String];
}

+ (UIImage *)xl_imageFromBase64EncodedString:(NSString *)base64String {
    if (!base64String) {
        return nil;
    }
    NSData * imageData =[[NSData alloc] initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *image = [UIImage imageWithData:imageData];
    return image;
}
@end
