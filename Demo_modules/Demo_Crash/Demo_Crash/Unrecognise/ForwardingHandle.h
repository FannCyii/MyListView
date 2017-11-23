//
//  ForwardingHandle.h
//  Demo_AOP_Crash
//
//  Created by kivan on 11/10/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^ForwardingHandleBlock)(void);

@interface ForwardingHandle : NSObject
- (instancetype)initWith:(id)target;

@property (nonatomic, strong)ForwardingHandleBlock block;

@end
