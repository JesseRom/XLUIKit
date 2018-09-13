//
//  UIView+XLExtension.h
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/13.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (XLExtension)
/**
 * 移除iOS11下搜索框的动画时，必须在 `viewDidAppear:` 中调用，且必须在调用 `becomeFirstResponder` 方法之后
 */
- (void)xl_removeLayerAnimationsRecursively;
@end
