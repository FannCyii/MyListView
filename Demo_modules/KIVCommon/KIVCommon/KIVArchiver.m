//
//  KIVArchiver.m
//  KIVCommon
//
//  Created by Fann on 28/12/2017.
//  Copyright © 2017 Fann. All rights reserved.
//

#import "KIVArchiver.h"

@implementation KIVArchiver

+ (instancetype)sharedInstance {
    static KIVArchiver *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)addObject:(id)aData forKey:(NSString *)identifior
{
    
}


@end
