//
//  KIVTimer.h
//  Demo_AOP_Crash
//
//  Created by kivan on 17/10/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KIVTimer : NSObject
+ (instancetype _Nullable )scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id _Nullable )aTarget selector:(SEL _Nullable )aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;

- (void)invalidate;
@end
