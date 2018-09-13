//
//  NSObject+XLSwizzling.m
//  XLFoundation
//
//  Created by HONGLUO on 2018/8/5.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "NSObject+XLSwizzling.h"
#import <objc/runtime.h>

@implementation NSObject(XLSwizzling)

- (void)mzd_hookSelector:(SEL)originalSelector
withDefaultImplementSelector:(SEL)defaultSelector
        swizzledSelector:(SEL)swizzledSelector
                forClass:(Class)aClass;
{
    Method defaultMethod  = class_getInstanceMethod(self.class, defaultSelector);
    Method swizzledMethod = class_getInstanceMethod(self.class, swizzledSelector);
    
    // 确保 delegate 类一定有 origin 实现
    BOOL result;
    if (![aClass instancesRespondToSelector:originalSelector]) {
        result = class_addMethod(
                                 aClass, originalSelector, method_getImplementation(defaultMethod), method_getTypeEncoding(defaultMethod));
    }
    Method originalMethod = class_getInstanceMethod(aClass, originalSelector);
    
    if (![aClass instancesRespondToSelector:swizzledSelector]) {
        result = class_addMethod(aClass, swizzledSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    } else {
        result = NO;
    }
    
    if (result) {
        swizzledMethod = class_getInstanceMethod(aClass, swizzledSelector);
        
        result = class_addMethod(
                                 aClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (result) {
            class_replaceMethod(aClass,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    }
}

+ (void)mzd_changeSelector:(SEL)sel withSelector:(SEL)swizzledSel
{
    Method originalMethod = class_getInstanceMethod(self, sel);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSel);
    
    BOOL result =
    class_addMethod(self, sel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (result) {
        class_replaceMethod(
                            self, swizzledSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (id)mzd_performSelector:(SEL)sel withObjects:(NSArray *)objects
{
    // 方法签名(方法的描述)
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:sel];
    if (signature == nil) {
        return nil;
    }
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target        = self;
    invocation.selector      = sel;
    
    // 设置参数
    NSInteger paramsCount = signature.numberOfArguments - 2; // 除self、_cmd以外的参数个数
    paramsCount           = MIN(paramsCount, objects.count);
    
    for (NSInteger i = 0; i < paramsCount; i++) {
        id object = objects[i];
        if ([object isKindOfClass:[NSNull class]]) continue;
        [invocation setArgument:&object atIndex:i + 2];
    }
    
    // 调用方法
    [invocation invoke];
    
    //获得返回值类型
    const char *returnType = signature.methodReturnType;
    
    //声明返回值变量
    id returnValue;
    
    //如果没有返回值，也就是消息声明为void，那么returnValue=nil
    if (!strcmp(returnType, @encode(void))) {
        returnValue = nil;
    }
    //如果返回值为对象，那么为变量赋值
    else if (!strcmp(returnType, @encode(id))) {
        [invocation getReturnValue:&returnValue];
    } else {
        //如果返回值为普通类型NSInteger  BOOL
        //返回值长度
        NSUInteger length = signature.methodReturnLength;
        
        //根据长度申请内存
        void *buffer = (void *)malloc(length);
        //为变量赋值
        [invocation getReturnValue:buffer];
        
        if (!strcmp(returnType, @encode(BOOL))) {
            returnValue = @(*((BOOL *)buffer));
        } else if (!strcmp(returnType, @encode(NSInteger))) {
            returnValue = @(*((NSInteger *)buffer));
        } else {
            returnValue = [NSValue valueWithBytes:buffer objCType:returnType];
        }
    }
    
    return returnValue;
}
@end
