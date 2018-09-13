//
//  UIImageView+XLExtension.m
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "UIImageView+XLExtension.h"
#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "SDImageCache+XLLocalPathCacheSupport.h"


@implementation UIImageView (XLExtension)
- (void)xl_setImageWithPath:(NSString *)path async:(BOOL)async
{
    if (async) {
        [self xl_setImageWithPath:path];
    }
    else {
        NSURL *url = [NSURL URLWithString:kXLSDWebCacheLocalhost];
        url = [url URLByAppendingPathComponent:path];
        self.image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:url.absoluteString];
    }
}


- (void)xl_setImageWithPath:(NSString *)path
{
    [self xl_setImageWithPath:path placeholderImage:nil completed:nil];
}

- (void)xl_setImageWithPath:(NSString *)path placeholderImage:(UIImage *)placeholder
{
    [self xl_setImageWithPath:path placeholderImage:placeholder completed:nil];
}

- (void)xl_setImageWithPath:(NSString *)path completed:(XLSDWebImageCompletionBlock)completedBlock
{
    [self xl_setImageWithPath:path placeholderImage:nil completed:completedBlock];
}

- (void)xl_setImageWithPath:(NSString *)path placeholderImage:(UIImage *)placeholder completed:(XLSDWebImageCompletionBlock)completedBlock
{
    [self sd_cancelCurrentImageLoad];
    
    self.image = placeholder;
    
    NSURL *url = [NSURL URLWithString:kXLSDWebCacheLocalhost];
    url = [url URLByAppendingPathComponent:path];
    [self xl_setImageWithURL:url placeholderImage:placeholder options:XLSDWebImageRetryFailed progress:nil completed:completedBlock];
}
@end

