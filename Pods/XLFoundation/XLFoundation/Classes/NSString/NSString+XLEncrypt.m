//
//  NSString+XLEncrypt.m
//  XLFoundation
//
//  Created by HONGLUO on 2018/8/5.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "NSString+XLEncrypt.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import "GTMMZDBase64.h"

@implementation NSString(XLEncrypt)

- (NSInteger)xl_bytes
{
    NSInteger count = 0;
    unichar c       = 0;
    for (int i = 0; i < [self length]; i++) {
        c = [self characterAtIndex:i];
        if (c >= 0 && c <= 127) {
            count++;
        } else {
            count += 2;
        }
    }
    return count;
}

- (NSUInteger)xl_hexValue
{
    NSUInteger result = 0;
    sscanf([self UTF8String], "%lx", (unsigned long *)&result);
    return result;
}

+ (NSString *)xl_md5OfFile:(NSString *)filePath {
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    if(!handle)
    {
        return nil;
    }
    
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    BOOL done = NO;
    while (!done)
    {
        NSData *fileData = [handle readDataOfLength:256];
        CC_MD5_Update(&md5, [fileData bytes], (CC_LONG)[fileData length]);
        if([fileData length] == 0)
            done = YES;
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++) {
        [outputString appendFormat:@"%02x", digest[count]];
    }
    
    return outputString;
}

- (NSString *)xl_md5
{
    if (self == nil || [self length] == 0) return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++) {
        [outputString appendFormat:@"%02x", outputBuffer[count]];
    }
    
    return outputString;
}

- (NSString *)xl_sha1WithKey:(NSString *)key
{
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self cStringUsingEncoding:NSUTF8StringEncoding];
    
    char digestStr[CC_SHA1_DIGEST_LENGTH];
    bzero(digestStr, 0);
    const char *secretKeyStr = [key UTF8String];
    CCHmac(kCCHmacAlgSHA1, secretKeyStr, strlen(secretKeyStr), value, strlen(value), digestStr);
    NSString *encodedDigest = [GTMMZDBase64 stringByWebSafeEncodingBytes:digestStr length:CC_SHA1_DIGEST_LENGTH padded:TRUE];
    return encodedDigest;
}

@end
