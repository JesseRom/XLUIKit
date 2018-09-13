//
//  UIImageView+XLSDWebImageWrapper.m
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "UIImageView+XLSDWebImageWrapper.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (XLSDWebImageWrapper)
- (NSURL *)xl_imageURL
{
    return [self sd_imageURL];
}

- (void)xl_setImageWithURL:(NSURL *)url
{
    [self xl_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:nil];
}

- (void)xl_setImageWithURL:(NSURL *)url async:(BOOL)async
{
    if (async) {
        [self xl_setImageWithURL:url];
    }
    else {
        self.image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:url.absoluteString];
    }
}

- (void)xl_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    [self xl_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:nil];
}

- (void)xl_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(XLSDWebImageOptions)options
{
    [self xl_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:nil];
}

- (void)xl_setImageWithURL:(NSURL *)url completed:(XLSDWebImageCompletionBlock)completedBlock
{
    [self xl_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:completedBlock];
}

- (void)xl_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(XLSDWebImageCompletionBlock)completedBlock
{
    [self xl_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:completedBlock];
}

- (void)xl_setImageWithURL:(NSURL *)url
           placeholderImage:(UIImage *)placeholder
                    options:(XLSDWebImageOptions)options
                  completed:(XLSDWebImageCompletionBlock)completedBlock
{
    [self xl_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:completedBlock];
}

- (void)xl_setImageWithURL:(NSURL *)url
           placeholderImage:(UIImage *)placeholder
                    options:(XLSDWebImageOptions)options
                   progress:(XLSDWebImageDownloaderProgressBlock)progressBlock
                  completed:(XLSDWebImageCompletionBlock)completedBlock
{
    if (options & XLSDWebImageSpliceIgnoreParameters) {
        NSString *urlStr = url.absoluteString;
        url = [NSURL URLWithString:[urlStr stringByAppendingString:@"&XLignore=1"]];
    }
    [self sd_setImageWithURL:url
            placeholderImage:placeholder
                     options:(SDWebImageOptions)options
                    progress:progressBlock
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                       if (completedBlock) {
                           completedBlock(image, error, imageURL);
                       }
                   }];
}

- (void)xl_setImageWithPreviousCachedImageWithURL:(NSURL *)url
                                  placeholderImage:(UIImage *)placeholder
                                           options:(XLSDWebImageOptions)options
                                          progress:(XLSDWebImageDownloaderProgressBlock)progressBlock
                                         completed:(XLSDWebImageCompletionBlock)completedBlock
{
    [self sd_setImageWithPreviousCachedImageWithURL:url
                                   placeholderImage:placeholder
                                            options:(SDWebImageOptions)options
                                           progress:progressBlock
                                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                              if (completedBlock) {
                                                  completedBlock(image, error, imageURL);
                                              }
                                          }];
}

- (void)xl_setImageWithURL:(NSURL *)url transformBlock:(XLSDWebImageTransformBlock)transformBlock
{
    [self xl_setImageWithURL:url placeholderImage:nil options:XLSDWebImageRetryFailed | XLSDWebImageAvoidAutoSetImage progress:nil transformBlock:transformBlock completed:nil];
}

- (void)xl_setImageWithURL:(NSURL *)url transformBlock:(XLSDWebImageTransformBlock)transformBlock completed:(XLSDWebImageCompletionBlock)completedBlock
{
    [self xl_setImageWithURL:url placeholderImage:nil options:XLSDWebImageRetryFailed | XLSDWebImageAvoidAutoSetImage progress:nil transformBlock:transformBlock completed:completedBlock];
}

- (void)xl_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder transformBlock:(XLSDWebImageTransformBlock)transformBlock completed:(XLSDWebImageCompletionBlock)completedBlock
{
    [self xl_setImageWithURL:url placeholderImage:placeholder options:XLSDWebImageRetryFailed | XLSDWebImageAvoidAutoSetImage progress:nil transformBlock:transformBlock completed:completedBlock];
}


- (void)xl_setImageWithURL:(NSURL *)url
           placeholderImage:(UIImage *)placeholder
                    options:(XLSDWebImageOptions)options
                   progress:(XLSDWebImageDownloaderProgressBlock)progressBlock
             transformBlock:(XLSDWebImageTransformBlock)transformBlock
                  completed:(XLSDWebImageCompletionBlock)completedBlock
{
    __weak UIImageView *wself = self;
    [self xl_setImageWithURL:url
             placeholderImage:placeholder
                      options:options | XLSDWebImageAvoidAutoSetImage
                     progress:progressBlock
                    completed:^(UIImage *image, NSError *error, NSURL *imageURL) {
                        __block UIImage *processedImage = nil;
                        if (image) {
                            if (transformBlock) {
                                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                    processedImage = transformBlock(image);
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        wself.image = processedImage ? processedImage : image;
                                        [wself setNeedsLayout];
                                        
                                        if (completedBlock) {
                                            completedBlock(processedImage ?: image, error, imageURL);
                                        }
                                    });
                                });
                                return;
                            }
                            else {
                                wself.image = image;
                                [wself setNeedsLayout];
                            }
                        }
                        if (completedBlock) {
                            completedBlock(image, error, imageURL);
                        }
                    }];
}


- (void)xl_setAnimationImagesWithURLs:(NSArray *)arrayOfURLs
{
    [self sd_setAnimationImagesWithURLs:arrayOfURLs];
}

- (void)xl_cancelCurrentImageLoad
{
    [self sd_cancelCurrentImageLoad];
}

- (void)xl_cancelCurrentAnimationImagesLoad
{
    [self sd_cancelCurrentAnimationImagesLoad];
}


@end
