//
//  SDImageCache+XLLocalPathCacheSupport.h
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <SDWebImage/SDImageCache.h>

OBJC_EXTERN NSString *kXLSDWebCacheLocalhost;

typedef void(^XLSDWebImageNoParamsBlock)();

@interface SDImageCache (XLLocalPathCacheSupport)

/**
 * Store an image into memory and disk cache at the given key.
 *
 * @param image The image to store
 * @param key   The unique image cache key, usually it's image absolute URL
 */
- (void)xl_storeImage:(UIImage *)image forPath:(NSString *)path;

/**
 * Store an image into memory and optionally disk cache at the given key.
 *
 * @param image  The image to store
 * @param key    The unique image cache key, usually it's image absolute URL
 * @param toDisk Store the image to disk cache if YES
 */
- (void)xl_storeImage:(UIImage *)image forPath:(NSString *)path toDisk:(BOOL)toDisk;

/**
 * Store an image into memory and optionally disk cache at the given key.
 *
 * @param image       The image to store
 * @param recalculate BOOL indicates if imageData can be used or a new data should be constructed from the UIImage
 * @param imageData   The image data as returned by the server, this representation will be used for disk storage
 *                    instead of converting the given image object into a storable/compressed image format in order
 *                    to save quality and CPU
 * @param key         The unique image cache key, usually it's image absolute URL
 * @param toDisk      Store the image to disk cache if YES
 */
- (void)xl_storeImage:(UIImage *)image recalculateFromImage:(BOOL)recalculate imageData:(NSData *)imageData forPath:(NSString *)path toDisk:(BOOL)toDisk;

/**
 * Store image NSData into disk cache at the given key.
 *
 * @param imageData The image data to store
 * @param key   The unique image cache key, usually it's image absolute URL
 */
- (void)xl_storeImageDataToDisk:(NSData *)imageData forPath:(NSString *)path;

/**
 * Query the memory cache synchronously.
 *
 * @param key The unique key used to store the wanted image
 */
- (UIImage *)xl_imageFromMemoryCacheForPath:(NSString *)path;

/**
 * Query the disk cache synchronously after checking the memory cache.
 *
 * @param key The unique key used to store the wanted image
 */
- (UIImage *)xl_imageFromDiskCacheForPath:(NSString *)path;

/**
 * Remove the image from memory and disk cache asynchronously
 *
 * @param key The unique image cache key
 */
- (void)xl_removeImageForPath:(NSString *)path;


/**
 * Remove the image from memory and disk cache asynchronously
 *
 * @param key             The unique image cache key
 * @param completion      An block that should be executed after the image has been removed (optional)
 */
- (void)xl_removeImageForPath:(NSString *)path withCompletion:(XLSDWebImageNoParamsBlock)completion;

/**
 * Remove the image from memory and optionally disk cache asynchronously
 *
 * @param key      The unique image cache key
 * @param fromDisk Also remove cache entry from disk if YES
 */
- (void)xl_removeImageForPath:(NSString *)path fromDisk:(BOOL)fromDisk;

/**
 * Remove the image from memory and optionally disk cache asynchronously
 *
 * @param key             The unique image cache key
 * @param fromDisk        Also remove cache entry from disk if YES
 * @param completion      An block that should be executed after the image has been removed (optional)
 */
- (void)xl_removeImageForPath:(NSString *)path fromDisk:(BOOL)fromDisk withCompletion:(XLSDWebImageNoParamsBlock)completion;


@end
