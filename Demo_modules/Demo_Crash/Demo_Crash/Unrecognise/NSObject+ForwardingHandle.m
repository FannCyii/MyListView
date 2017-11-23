//
//  NSObject+ForwardingHandle.m
//  Demo_AOP_Crash
//
//  Created by kivan on 11/10/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "NSObject+ForwardingHandle.h"
#import <objc/runtime.h>
#import "ForwardingHandle.h"

@implementation NSObject (ForwardingHandle)

+ (void)load{
    [self swizzleMethod:@selector(forwardingTargetForSelector:) withCurrentMethod:@selector(myforwardingTargetForSelector:)];
}

- (id)myforwardingTargetForSelector:(SEL)aSelector
{
    return [self myforwardingTargetForSelector:aSelector];
    
    ForwardingHandle *forward = [[ForwardingHandle alloc] initWith:self];
    forward.block = ^{
        NSLog(@"补救处理");
    };
    NSLog(@"PROTECTOR: call stack: %@", [NSThread callStackSymbols]);
    return forward;
}

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

@end
