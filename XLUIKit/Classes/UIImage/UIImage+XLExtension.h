//
//  UIImage+XLExtension.h
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString *const kXLSaveImageToPhotosAlbumSuccessNotification;
FOUNDATION_EXPORT NSString *const kXLSaveImageToPhotosAlbumFailureNotification;

@interface UIImage (XLExtension)
/**
 * 从 bundle 中加载 image
 * @param imageName 图片名称
 * @param bundleName 包名
 * @return bundle 中存在 返回 UIImage，否则返回 nil
 */
+ (UIImage *)xl_imageNamed:(NSString *)imageName inBundle:(NSString *)bundleName;

#pragma mark - snapshot

//获得屏幕图像
+ (UIImage *)xl_imageFromView:(UIView *)view;

//获得某个范围内的屏幕图像
+ (UIImage *)xl_imageFromView:(UIView *)view inRect:(CGRect)rect;

#pragma mark - save

- (void)xl_saveToPhotosAlbum;

#pragma mark - rotate

- (UIImage *)xl_imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)xl_imageRotatedByDegrees:(CGFloat)degrees;
- (UIImage *)xl_adjustRotation;
@end
