//
//  UIImage+XLUIKit.m
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "UIImage+XLUIKit.h"
#import "NSBundle+XLUIKit.h"

@implementation UIImage (XLUIKit)
+ (UIImage *)xl_imageNamedInXLUIKitBundle:(NSString *)imageName {
    NSBundle *bundle = [NSBundle xl_UIKit_bundle];
    return [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
}
@end
