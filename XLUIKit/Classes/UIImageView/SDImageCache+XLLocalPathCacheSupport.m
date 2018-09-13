//
//  SDImageCache+XLLocalPathCacheSupport.m
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "SDImageCache+XLLocalPathCacheSupport.h"
#import <objc/runtime.h>

NSString *kXLSDWebCacheLocalhost = @"XLwebimage://localhost";

@implementation SDImageCache (XLLocalPathCacheSupport)

+ (void)load
{
    SEL originalSelector = @selector(defaultCachePathForKey:);
    SEL swizzledSelector = @selector(xl_defaultCachePathForKey:);
    
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    
    BOOL result = class_addMethod(self,
                                  originalSelector,
                                  method_getImplementation(swizzledMethod),
                                  method_getTypeEncoding(swizzledMethod));
    
    if (result) {
        class_replaceMethod(self,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (NSString *)xl_defaultCachePathForKey:(NSString *)key
{
    if ([key hasPrefix:kXLSDWebCacheLocalhost]) {
        return [key stringByReplacingOccurrencesOfString:kXLSDWebCacheLocalhost withString:@""];
    }
    else {
        return [self xl_defaultCachePathForKey:key];
    }
}

- (void)xl_storeImage:(UIImage *)image forPath:(NSString *)path
{
    [self xl_storeImage:image recalculateFromImage:YES imageData:nil forPath:path toDisk:YES];
}

- (void)xl_storeImage:(UIImage *)image forPath:(NSString *)path toDisk:(BOOL)toDisk
{
    [self xl_storeImage:image recalculateFromImage:YES imageData:nil forPath:path toDisk:toDisk];
}

- (void)xl_storeImage:(UIImage *)image recalculateFromImage:(BOOL)recalculate imageData:(NSData *)imageData forPath:(NSString *)path toDisk:(BOOL)toDisk
{
    NSURL *url = [NSURL URLWithString:kXLSDWebCacheLocalhost];
    url = [url URLByAppendingPathComponent:path];
    [self storeImage:image recalculateFromImage:recalculate imageData:imageData forKey:url.absoluteString toDisk:toDisk];
}

- (void)xl_storeImageDataToDisk:(NSData *)imageData forPath:(NSString *)path
{
    if (!imageData) {
        return;
    }
    
    Ivar var =  class_getInstanceVariable(SDImageCache.class, "_fileManager");
    NSFileManager *fileManager = (NSFileManager *)object_getIvar(self, var);
    
    NSURL *url = [NSURL URLWithString:kXLSDWebCacheLocalhost];
    url = [url URLByAppendingPathComponent:path];
    
    // defaultCachePathForKey 方法被替换为返回 path 路径
    NSString *cachePathForKey = [self defaultCachePathForKey:url.absoluteString];
    NSString *cacheDirectory = [cachePathForKey stringByDeletingLastPathComponent];
    if (![fileManager fileExistsAtPath:cacheDirectory]) {
        [fileManager createDirectoryAtPath:cacheDirectory withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    
    [fileManager createFileAtPath:cachePathForKey contents:imageData attributes:nil];
}

- (UIImage *)xl_imageFromMemoryCacheForPath:(NSString *)path
{
    NSURL *url = [NSURL URLWithString:kXLSDWebCacheLocalhost];
    url = [url URLByAppendingPathComponent:path];
    return [self imageFromMemoryCacheForKey:url.absoluteString];
}

- (UIImage *)xl_imageFromDiskCacheForPath:(NSString *)path
{
    NSURL *url = [NSURL URLWithString:kXLSDWebCacheLocalhost];
    url = [url URLByAppendingPathComponent:path];
    return [self imageFromDiskCacheForKey:url.absoluteString];
}

- (void)xl_removeImageForPath:(NSString *)path
{
    [self xl_removeImageForPath:path withCompletion:nil];
}

- (void)xl_removeImageForPath:(NSString *)path withCompletion:(XLSDWebImageNoParamsBlock)completion
{
    [self xl_removeImageForPath:path fromDisk:YES withCompletion:completion];
}

- (void)xl_removeImageForPath:(NSString *)path fromDisk:(BOOL)fromDisk
{
    [self xl_removeImageForPath:path fromDisk:fromDisk withCompletion:nil];
}

- (void)xl_removeImageForPath:(NSString *)path fromDisk:(BOOL)fromDisk withCompletion:(XLSDWebImageNoParamsBlock)completion
{
    NSURL *url = [NSURL URLWithString:kXLSDWebCacheLocalhost];
    url = [url URLByAppendingPathComponent:path];
    [self removeImageForKey:url.absoluteString fromDisk:fromDisk withCompletion:completion];
}

@end
