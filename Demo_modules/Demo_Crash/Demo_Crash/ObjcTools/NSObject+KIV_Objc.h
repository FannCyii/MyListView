//
//  NSObject+KIV_Objc.h
//  Demo_AOP_Crash
//
//  Created by kivan on 18/10/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KIV_Objc)

/**
 新方法swizzle 就方法，只在+load中使用才生效
 只执行一次
 @param originSelector 原方法
 @param currentSelector 新方法
 */
+ (void)swizzleMethod:(SEL)originSelector withCurrentMethod:(SEL)currentSelector;

/**
 新方法swizzle 就方法，只在+load中使用才生效
 可执行多次
 @param originSelector 原方法
 @param currentSelector 新方法
 */
+ (void)swizzleMultiMethod:(SEL)originSelector withCurrentMethod:(SEL)currentSelector;

@end
