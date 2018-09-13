//
//  UIView+XLExtension.m
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/13.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "UIView+XLExtension.h"

@implementation UIView (XLExtension)
- (void)xl_removeLayerAnimationsRecursively {
    [self.layer removeAllAnimations];
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView *obj, NSUInteger idx, BOOL *stop) {
        [obj xl_removeLayerAnimationsRecursively];
    }];
}
@end
