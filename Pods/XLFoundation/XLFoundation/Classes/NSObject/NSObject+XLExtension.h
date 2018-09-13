//
//  NSObject+XLExtension.h
//  XLFoundation
//
//  Created by HONGLUO on 2018/8/5.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject(XLExtension)

- (id)mzd_performSelector:(SEL)selector withObjects:(NSArray *)objects;

@end
