//
//  NSBundle+XLUIKit.m
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "NSBundle+XLUIKit.h"

@implementation NSBundle (XLUIKit)
+ (instancetype)xl_UIKit_bundle {
    NSString *mainBundlePath = [NSBundle mainBundle].bundlePath;
    NSString *bundlePath = [NSString stringWithFormat:@"%@/%@",mainBundlePath,@"XLUIKit.bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    if (!bundle) {
        bundlePath = [NSString stringWithFormat:@"%@/%@",mainBundlePath,@"Frameworks/XLUIKit.framework/XLUIKit.bundle"];
        bundle = [NSBundle bundleWithPath:bundlePath];
    }
    return bundle;
}
@end
