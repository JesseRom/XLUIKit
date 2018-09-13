//
//  UIDevice+XLInfo.m
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "UIDevice+XLInfo.h"
#import "Reachability.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

//for mac
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <sys/utsname.h>
#include <net/if.h>
#include <net/if_dl.h>

//for idfa
#import <AdSupport/AdSupport.h>

@implementation UIDevice (XLInfo)
+ (NSString *)xl_network {
    //为适配iPhoneX弃用通过状态栏获取当前的网络状态，改用Reachability
    NSString *stateString = @"wifi";
    switch ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]) {
        case NotReachable: {
            stateString = @"notReachable";
        }
            break;
        case ReachableVia2G: {
            stateString = @"2G";
        }
            break;
        case ReachableVia3G: {
            stateString = @"3G";
        }
            break;
        case ReachableVia4G: {
            stateString = @"4G";
        }
            break;
        case ReachableViaWiFi: {
            stateString = @"wifi";
        }
            break;
        default:
            break;
    }
    return stateString;
}

+ (NSString *)xl_mac
{
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *macString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return macString;
}

+ (NSString *)xl_mobileNetworkCode
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    
    CTCarrier *carrier = [info subscriberCellularProvider];
    
    NSString *mnc;
    
    if (!carrier.isoCountryCode) {
        mnc = @"";
    } else {
        mnc = [carrier mobileNetworkCode];
    }
    
    return mnc;
}

+ (NSString *)xl_idfa
{
    NSBundle *adSupportBundle = [NSBundle bundleWithPath:@"/System/Library/Frameworks/AdSupport.framework"];
    [adSupportBundle load];
    
    if (adSupportBundle == nil) {
        return @"";
    }
    
    Class asIdentifierMClass = NSClassFromString(@"ASIdentifierManager");
    if (asIdentifierMClass == nil) {
        return @"";
    }
    
    ASIdentifierManager *asIM = [[ASIdentifierManager alloc] init];
    
    if (asIM == nil) {
        return @"";
    }
    if (asIM.advertisingTrackingEnabled) {
        return [asIM.advertisingIdentifier UUIDString];
    }
    
    return [asIM.advertisingIdentifier UUIDString];
}

+ (NSString *)xl_idfv
{
    if([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
        return [[UIDevice currentDevice].identifierForVendor UUIDString];
    }
    
    return @"";
}

+ (NSString *)xl_model
{
    struct utsname sInfo;
    uname(&sInfo);
    NSString *machineName = [NSString stringWithCString:sInfo.machine encoding:NSUTF8StringEncoding];
    
    return machineName;
}

- (NSString *)xl_uuid
{
    return nil;
}

+ (BOOL)xl_isJailBroken
{
    BOOL cydia = NO;
    BOOL binBash = NO;
    NSString *filePath = @"/Applications/Cydia.app";
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        cydia = YES;
    }
    
    FILE * f = fopen("/bin/bash", "r");
    if (f != NULL) {
        binBash = YES;
    }
    fclose(f);
    
    if (cydia || binBash) {
        return YES;
    }
    return NO;
}

+ (NSString *)xl_appVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (BOOL)xl_uponVersion:(CGFloat)version
{
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= version;
}

+ (BOOL)xl_underVersion:(CGFloat)version
{
    return [[[UIDevice currentDevice] systemVersion] floatValue] < version;
}

+ (BOOL)xl_isIphone5s
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceString isEqualToString:@"iPhone5,1"] ||
        [deviceString isEqualToString:@"iPhone5,2"] ||
        [deviceString isEqualToString:@"iPhone5,3"] ||
        [deviceString isEqualToString:@"iPhone5,4"] ||
        [deviceString isEqualToString:@"iPhone6,1"] ||
        [deviceString isEqualToString:@"iPhone6,2"]
        ) {
        return YES;
    }
    return NO;
}

+ (BOOL)xl_isiPhoneX {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //Simulator
    if ([platform isEqualToString:@"i386"])          return YES;
    if ([platform isEqualToString:@"x86_64"])        return YES;
    //iPhone
    if ([platform isEqualToString:@"iPhone10,3"])    return YES;
    if ([platform isEqualToString:@"iPhone10,6"])    return YES;
    return NO;
}

+ (BOOL)xl_isPlus
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    if (fabs(scale - 3.0) < 0.0001) {
        return YES;
    } else {
        return NO;
    }
}
@end
