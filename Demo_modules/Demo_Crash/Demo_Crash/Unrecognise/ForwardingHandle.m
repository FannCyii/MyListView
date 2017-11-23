//
//  ForwardingHandle.m
//  Demo_AOP_Crash
//
//  Created by kivan on 11/10/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "ForwardingHandle.h"
#import <objc/runtime.h>

@interface ForwardingHandle ()
@property (nonatomic, strong) id targetInstence;

@end

@implementation ForwardingHandle

- (instancetype)initWith:(id)target
{
    self = [super init];
    if (self) {
        self.targetInstence = target;
    }
    return self;
}

//- (void)buttonAction:(UIButton *)sender
//{
//    NSLog(@"点击");
//}


+ (BOOL)resolveClassMethod:(SEL)sel{
    class_addMethod(self, sel, (IMP)shandle, "v@:");
    return YES;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    class_addMethod(self, sel, (IMP)handle, "v@:");
    return YES;
}
static void shandle()
{
    NSLog(@"没有这个静态方法");
}

void handle(id self,SEL _cmd)
{
    ForwardingHandle *forward = (ForwardingHandle *)self;
    NSLog(@"%@中未找到改方法%@",forward.targetInstence,NSStringFromSelector(_cmd));
    if (forward.block) {
        forward.block();
    }
    
}

@end
