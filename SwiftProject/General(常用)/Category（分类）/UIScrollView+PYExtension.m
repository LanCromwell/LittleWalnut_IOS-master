//
//  UIScrollView+PYExtension.m
//  Prome
//
//  Created by liyan on 2017/9/21.
//  Copyright © 2017年 liyan. All rights reserved.
//

#import "UIScrollView+PYExtension.h"
#import <objc/runtime.h>

@implementation UIScrollView (PYExtension)

+ (void)load {
    Method systemMethod = class_getInstanceMethod(self, @selector(initWithFrame:));
    Method customMethod = class_getInstanceMethod(self, @selector(m_initWithFrame:));
    // 交换方法的实现
    method_exchangeImplementations(systemMethod, customMethod);
}


- (instancetype)m_initWithFrame:(CGRect)frame {

    UIScrollView *scrollV = [self m_initWithFrame:frame];
    if (@available(iOS 11.0, *)) {
        scrollV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return scrollV;
}


@end
