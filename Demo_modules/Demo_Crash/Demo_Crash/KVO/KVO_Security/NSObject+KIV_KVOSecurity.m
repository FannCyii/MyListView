//
//  NSObject+KIV_KVOSecurity.m
//  Demo_AOP_Crash
//
//  Created by kivan on 18/10/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "NSObject+KIV_KVOSecurity.h"
#import "Aspects.h"
#import <objc/runtime.h>
#import "NSObject+KIV_Objc.h"

#include <stdlib.h>
#include <execinfo.h>


@interface NSObject ()
@property (nonatomic, strong)NSMutableDictionary * kiv_oberverDictionary;

@end

@implementation NSObject (KIV_KVOSecurity)
+ (void)load
{
    //[self monitorKVO];
    [self swizzleKVO];
}

#pragma mark - 添加数组

/**
 用于存储 观察者的keyPath

 @return 存储字典
 */
- (NSMutableDictionary *)kiv_oberverDictionary
{
   return  objc_getAssociatedObject(self, _cmd);
}

- (void)setKiv_oberverDictionary:(NSMutableDictionary *)newDir
{
    return objc_setAssociatedObject(self, @selector(kiv_oberverDictionary), newDir, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark - 监控 KVO
//+ (void)monitorKVO
//{
//    NSError *error;
//    [NSObject aspect_hookSelector:@selector(addObserver:forKeyPath:options:context:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> params){
//    } error:&error];
//
//    [NSObject aspect_hookSelector:@selector(removeObserver:forKeyPath:context:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> params){
//        NSLog(@"=====removeObserver1:%@",params.instance);
//    }error:&error];
//
//    [NSObject aspect_hookSelector:@selector(removeObserver:forKeyPath:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> params){
//        NSLog(@"=====removeObserver2:%@",params.instance);
//    }error:&error];
//
//    [NSObject aspect_hookSelector:@selector(observeValueForKeyPath:ofObject:change:context:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> params){
//        NSLog(@"=====observeValueForKeyPath:%@",params.instance);
//    } error:&error];
//
//    //    [NSObject aspect_hookSelector:NSSelectorFromString(@"dealloc") withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> params){
//    //        NSLog(@"=====dealloc");
//    //    } error:&error];
//    //
//}

#pragma mark - KVO处理 Security KVO
+ (void)swizzleKVO
{
    [NSObject swizzleMethod:@selector(addObserver:forKeyPath:options:context:) withCurrentMethod:@selector(kiv_AddObserver:forKeyPath:options:context:)];
    [NSObject swizzleMultiMethod:@selector(removeObserver:forKeyPath:) withCurrentMethod:@selector(kiv_RemoveObserver:forKeyPath:)];
    [NSObject swizzleMethod:@selector(removeObserver:forKeyPath:context:) withCurrentMethod:@selector(kiv_RemoveObserver:forKeyPath:context:)];
 
    [NSObject swizzleMultiMethod:NSSelectorFromString(@"observeValueForKeyPath:ofObject:change:context:") withCurrentMethod:@selector(kiv_ObserveValueForKeyPath:ofObject:change:context:)];
    
    [NSObject swizzleMultiMethod:NSSelectorFromString(@"dealloc") withCurrentMethod:@selector(kiv_Dealloc)];
}
- (void)kiv_AddObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    if ([self hasAdded:keyPath oberver:observer]) {
        NSLog(@"kvo=======%@重复添加%@",self,keyPath);
//        NSLog(@"%@",[NSThread callStackSymbols]);
    }else{
        [self kiv_AddHandleWithOberver:observer withKeyPath:keyPath];
        [self kiv_AddObserver:observer forKeyPath:keyPath options:options context:context];
    }
}

- (void)kiv_RemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath
{
    if ([self hasAdded:keyPath oberver:observer]) {
        [self kiv_DeletedHandleWithOberver:observer withKeyPath:keyPath];
        [self kiv_RemoveObserver:observer forKeyPath:keyPath];
    }else{
        NSLog(@"kvo=======%@重复移除%@",self,keyPath);
//        NSLog(@"%@",[NSThread callStackSymbols]);
    }
}


- (void)kiv_RemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(nullable void *)context
{
    if ([self hasAdded:keyPath oberver:observer]) {
        [self kiv_DeletedHandleWithOberver:observer withKeyPath:keyPath];
        [self kiv_RemoveObserver:observer forKeyPath:keyPath context:context];
    }else{
        NSLog(@"kvo=======%@重复移除%@",self,keyPath);
//        NSLog(@"%@",[NSThread callStackSymbols]);
    }
}
//这里不能这么实现，而是用unrecognic来实现捕获处理
- (void)kiv_ObserveValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    
    if ([object respondsToSelector:@selector(kiv_ObserveValueForKeyPath:ofObject:change:context:)]) {
        [object kiv_ObserveValueForKeyPath:keyPath ofObject:object change:change context:context];
    }else{
        NSLog(@"kvo=======%@没有实现kiv_ObserveValueForKeyPath：：：方法",self);
//        NSLog(@"%@",[NSThread callStackSymbols]);
    }
}

- (void)kiv_Dealloc
{
    if (self.kiv_oberverDictionary.count > 0) {
        for (NSString *keyPath in self.kiv_oberverDictionary.allKeys) {
            NSLog(@"kvo=======未移除观察者<%@-%@>",self.kiv_oberverDictionary[keyPath],keyPath);
            [self removeObserver:self.kiv_oberverDictionary[keyPath] forKeyPath:keyPath];
        }
    }
    [self kiv_Dealloc];
}
- (void)kiv_AddHandleWithOberver:(id)observer withKeyPath:keyPath
{
    if (!observer) {
        return;
    }
    if (!self.kiv_oberverDictionary) {
        self.kiv_oberverDictionary = [NSMutableDictionary dictionary];
    }
    
    NSInteger j = 0;
    for (;j < self.kiv_oberverDictionary.allKeys.count; ++j) {
        NSString *kp = self.kiv_oberverDictionary.allKeys[j];
        if ([kp isEqualToString:keyPath]) {
            NSInteger i = 0;
            NSMutableArray *array = self.kiv_oberverDictionary[keyPath];
            for (;i< array.count;++i) {
                id objc = array[i];
                if ([objc isEqual:observer]) {
                    break;
                }
            }
            if (i == array.count) {
                if (!array) {
                    array = [NSMutableArray array];
                }
                [array addObject:observer];
                self.kiv_oberverDictionary[keyPath] = array;
            }
            break;
        }
    }

    if (j == self.kiv_oberverDictionary.allKeys.count) {
        self.kiv_oberverDictionary[keyPath] = @[observer].mutableCopy;
    }
    
//    NSLog(@"object:%@:\n%@",self,self.kiv_oberverDictionary.allKeys);
//    for (id obj in self.kiv_oberverDictionary[keyPath]) {
//        NSLog(@"\n%@",NSStringFromClass([obj class]));
//    }
}

- (void)kiv_DeletedHandleWithOberver:(id)observer withKeyPath:keyPath
{
    if (!observer) {
        return;
    }
    for (NSString *kp in self.kiv_oberverDictionary.allKeys) {
        if ([kp isEqualToString:keyPath]) {
            NSInteger i = 0;
            NSMutableArray *array = self.kiv_oberverDictionary[keyPath];
            for (;i< array.count;++i) {
                id objc = array[i];
                if ([objc isEqual:observer]) {
                    [array removeObject:observer];
                    break;
                }
            }
            break;
        }
    }
}

- (BOOL)hasAdded:(NSString *)keyPath oberver:(id)observer
{
    NSArray *array = self.kiv_oberverDictionary[keyPath];
    for (id objc in array) {
        if ([objc isEqual:observer]) {
            return YES;
        }
    }
    return NO;
}

@end
