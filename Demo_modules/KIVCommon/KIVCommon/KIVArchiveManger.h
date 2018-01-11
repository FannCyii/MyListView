//
//  KIVArchiveManger.h
//  KIVCommon
//
//  Created by Fann on 11/01/2018.
//  Copyright © 2018 Fann. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXTERN  NSString *ArchiveValue;
FOUNDATION_EXTERN  NSString *ArchiveKey;

typedef void (^KIVArchiveCompleteBlock)(void);

@interface KIVArchiveManger : NSObject

@property (nonatomic, copy) KIVArchiveCompleteBlock completeBlock;

@end
