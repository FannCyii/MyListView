//
//  KIVArchiver.h
//  KIVCommon
//
//  Created by Fann on 28/12/2017.
//  Copyright © 2017 Fann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KIVArchiver : NSObject
+ (instancetype)sharedInstance;
- (void)addObject:(id)aData forKey:(NSString *)identifior;


@end
