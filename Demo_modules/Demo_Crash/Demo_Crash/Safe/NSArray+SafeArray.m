//
//  NSArray+SafeArray.m
//  Demo_AOP_Crash
//
//  Created by kivan on 31/10/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "NSArray+SafeArray.h"
#import "NSObject+KIV_Objc.h"
#import "KIVLog.h"
@implementation NSArray (SafeArray)

+(void)load{
    NSLog(@"[NSArray SAFE]");
    [self swizzleMultiMethod:@selector(objectAtIndexedSubscript:) withCurrentMethod:@selector(safeArrayObjectAtIndexedSubscript:)];
    [self swizzleMultiMethod:@selector(subarrayWithRange:) withCurrentMethod:@selector(safeSubarrayWithRange:)];
    
    [self swizzleMultiMethod:@selector(indexOfObject:) withCurrentMethod:@selector(safeIndexOfObject:)];
    
    //使用[]越界会调用__NSArrayI的该方法
    Class arrayIClass = NSClassFromString(@"__NSArrayI");
    [arrayIClass swizzleMultiMethod:@selector(objectAtIndexedSubscript:) withCurrentMethod:@selector(safeArrayIObjectAtIndexedSubscript:)];
    
    [arrayIClass swizzleMultiMethod:@selector(objectAtIndex:) withCurrentMethod:@selector(safeArrayIObjectAtIndex:)];
    
//    Class arrayWithObjClass = NSClassFromString(@"__NSPlaceholderArray");
//    [arrayWithObjClass swizzleMultiMethod:@selector(initWithObjects:count:) withCurrentMethod:@selector(safeArrayInitWithObjects:count:)];
}

- (id)safeArrayObjectAtIndexedSubscript:(NSInteger)index
{
    if (index >= self.count) {
        KIVWarning(@"index %ld beyond bounds of array:[0-%ld]",(long)index,self.count);
        return nil;
    }else {
        return [self safeArrayObjectAtIndexedSubscript:index];
    }
}

- (id)safeArrayIObjectAtIndexedSubscript:(NSInteger)index
{
    if (index >= self.count) {
        KIVWarning(@"index %ld beyond bounds of array:[0-%ld]",(long)index,(unsigned long)self.count);
        return nil;
    }else {
        return [self safeArrayIObjectAtIndexedSubscript:index];
    }
}

- (id)safeArrayIObjectAtIndex:(NSInteger)index
{
    if(index >= self.count){
        KIVWarning(@"index %ld beyond bounds of array:[0-%ld]",(long)index,(unsigned long)self.count);
        return nil;
    }else{
        return [self safeArrayIObjectAtIndex:index];
    }
}

- (id)safeSubarrayWithRange:(NSRange)range
{
    if(range.location >= self.count){
        return nil;
    }
    NSInteger newlength = range.location + range.length > self.count?self.count - range.location:range.length;
    return [self safeSubarrayWithRange:NSMakeRange(range.location, newlength)];
}

//+ (instancetype)safeArrayInitWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt
//{
//    if(!objects || objects == NULL){
//        return nil;
//    }
//    NSInteger count = sizeof(objects)/sizeof(objects[0]);
//    if(count < cnt){
//        return [self safeArrayInitWithObjects:objects count:count];
//    }
//    return [self safeArrayInitWithObjects:objects count:cnt];
//}

- (NSUInteger)safeIndexOfObject:(id)anObject
{
    if(!anObject){
        return NSNotFound;
    }
    return [self safeIndexOfObject:anObject];
}

@end
