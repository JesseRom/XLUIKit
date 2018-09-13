//
//  NSString+XLJSON.m
//  XLFoundation
//
//  Created by HONGLUO on 2018/8/5.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "NSString+XLJSON.h"

@implementation NSString(XLJSON)

- (id)mzd_JSONObject
{
    if (!self) {
        return nil;
    }
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        NSException *e = [NSException exceptionWithName:@"MZD JSONParser Error" reason:error.localizedDescription userInfo:nil];
        [e raise];
    }
    
    return jsonObject;
}

+ (NSString *)mzd_stringWithJSONObject:(id)object
{
    if (!self) {
        return nil;
    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    
    if (error) {
        NSException *e = [NSException exceptionWithName:@"MZD JSONParser Error" reason:error.localizedDescription userInfo:nil];
        [e raise];
    }
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
