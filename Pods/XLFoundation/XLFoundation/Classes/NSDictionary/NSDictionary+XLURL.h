//
//  NSDictionary+XLURL.h
//  XLFoundation
//
//  Created by HONGLUO on 2018/8/4.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary(XLURL) 

//e.g. @{@"name":@"luohong",@"age":@(30)} --> name=luohong&age=30
- (NSString *)xl_joinURLQueries;

@end
