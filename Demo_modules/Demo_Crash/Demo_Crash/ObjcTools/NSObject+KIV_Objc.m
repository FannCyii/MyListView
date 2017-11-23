//
//  NSObject+KIV_Objc.m
//  Demo_AOP_Crash
//
//  Created by kivan on 18/10/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "NSObject+KIV_Objc.h"
#import <objc/runtime.h>
@implementation NSObject (KIV_Objc)

+(void)load{
    //这是一个模板
}
/**
 新方法swizzle 就方法，只在+load中使用才生效
 
 @param originSelector 原方法
 @param currentSelector 新方法
 */
+ (void)swizzleMethod:(SEL)originSelector withCurrentMethod:(SEL)currentSelector{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class selfClass = [self class];
        Method oriMethod = class_getInstanceMethod(selfClass, originSelector);
        Method cusMethod = class_getInstanceMethod(selfClass, currentSelector);
        
        BOOL addSucc = class_addMethod(selfClass, originSelector, method_getImplementation(cusMethod), method_getTypeEncoding(cusMethod));
        if (addSucc) {
            class_replaceMethod(selfClass, currentSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        }else {
            method_exchangeImplementations(oriMethod, cusMethod);
        }
    });
}

+ (void)swizzleMultiMethod:(SEL)originSelector withCurrentMethod:(SEL)currentSelector{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
        Class selfClass = [self class];
        Method oriMethod = class_getInstanceMethod(selfClass, originSelector);
        Method cusMethod = class_getInstanceMethod(selfClass, currentSelector);
        
        BOOL addSucc = class_addMethod(selfClass, originSelector, method_getImplementation(cusMethod), method_getTypeEncoding(cusMethod));
        if (addSucc) {
            class_replaceMethod(selfClass, currentSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        }else {
            method_exchangeImplementations(oriMethod, cusMethod);
        }
//    });
}


@end
