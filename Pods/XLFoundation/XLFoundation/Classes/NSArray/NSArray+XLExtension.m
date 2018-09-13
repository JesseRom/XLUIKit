//
//  NSArray+XLExtension.m
//  XLFoundation
//
//  Created by HONGLUO on 2018/8/2.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "NSArray+XLExtension.h"

@implementation NSArray(XLExtension)

- (NSArray *)xl_reversed {
    NSMutableArray *result = [NSMutableArray array];
    NSEnumerator *reversed = self.reverseObjectEnumerator;
    id obj;
    while (obj = [reversed nextObject]) {
        [result addObject:obj];
    }
    return [result copy];
}

@end
