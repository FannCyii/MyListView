//
//  KIVTimer.m
//  Demo_AOP_Crash
//
//  Created by kivan on 17/10/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "KIVTimer.h"

@interface KIVTimer ()
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL targetSEL;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation KIVTimer

+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo
{
    KIVTimer *kivTimer = [[KIVTimer alloc] init];
    kivTimer.target = aTarget;
    kivTimer.targetSEL = aSelector;
    kivTimer.timer = [NSTimer scheduledTimerWithTimeInterval:ti target:kivTimer selector:@selector(kivTimerSelector:) userInfo:userInfo repeats:yesOrNo];
    return kivTimer;
}

- (void)kivTimerSelector:(NSTimer *)timer
{
    if (self.target) {
        if ([self.target respondsToSelector:self.targetSEL]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self.target performSelector:self.targetSEL withObject:timer.userInfo];
#pragma clang diagnostic pop
            
        }else{
            NSLog(@"%@没有实现TimerTarget",self.target);
        }
    }else{
        [timer invalidate];
    }
}

- (void)invalidate
{
    [self.timer invalidate];
    self.timer = nil;
    NSLog(@"timer invlaidate");
}



@end
