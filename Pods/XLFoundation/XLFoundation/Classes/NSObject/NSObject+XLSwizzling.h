//
//  NSObject+XLSwizzling.h
//  XLFoundation
//
//  Created by HONGLUO on 2018/8/5.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject(XLSwizzling)

- (void)mzd_hookSelector:(SEL)originalSelector
withDefaultImplementSelector:(SEL)defaultSelector
        swizzledSelector:(SEL)swizzledSelector
                forClass:(Class)aClass;

+ (void)mzd_changeSelector:(SEL)sel withSelector:(SEL)swizzledSel;
- (id)mzd_performSelector:(SEL)sel withObjects:(NSArray *)objects;

@end
