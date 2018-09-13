//
//  UIApplication+XLSandbox.h
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIApplication(XLSandbox)

/**
 *  获取当前应用程序 sandbox 的 Documents 文件 URL
 *
 *  @return Documents URL
 */
+ (NSURL *)xl_documentsDirectoryURL;

/**
 *  获取当前应用程序 sandbox 的 Caches 文件 URL
 *
 *  @return Caches URL
 */
+ (NSURL *)xl_cachesDirectoryURL;

/**
 *  获取当前应用程序 sandbox 的 Downloads 文件 URL
 *
 *  @return Downloads URL
 */
+ (NSURL *)xl_downloadsDirectoryURL;

/**
 *  获取当前应用程序 sandbox 的 Library 文件 URL
 *
 *  @return Library URL
 */
+ (NSURL *)xl_libraryDirectoryURL;

/**
 * Returns the file URL of the application support directory.
 */
+ (NSURL *)xl_applicationSupportDirectoryURL;

/**
 *  获取当前应用程序 sandbox 的 Documents 文件 Path
 *
 *  @return Documents Path
 */
+ (NSString *)xl_documentsDirectoryPath;

/**
 *  获取当前应用程序 sandbox 的 Caches 文件 Path
 *
 *  @return Caches Path
 */
+ (NSString *)xl_cachesDirectoryPath;

/**
 *  获取当前应用程序 sandbox 的 Downloads 文件 Path
 *
 *  @return Downloads Path
 */
+ (NSString *)xl_downloadsDirectoryPath;

/**
 *  获取当前应用程序 sandbox 的 Library 文件 Path
 *
 *  @return Library Path
 */
+ (NSString *)xl_libraryDirectoryPath;

@end
