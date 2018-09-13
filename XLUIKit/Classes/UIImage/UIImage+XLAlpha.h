//
//  UIImage+XLAlpha.h
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (XLAlpha)
- (BOOL)xl_hasAlpha;
- (UIImage *)xl_imageWithAlpha;
- (UIImage *)xl_transparentBorderImage:(NSUInteger)borderSize;
@end
