//
//  KIVArchiverManager.h
//  Demolibrarys
//
//  Created by Fann on 28/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXTERN  NSString *LOGSTITLE;
FOUNDATION_EXTERN  NSString *LOGSCONTENT;

@interface KIVArchiverManager : NSObject

- (instancetype)initWithIdentifior:(NSString *)identifior;

- (void)saveLogs:(id)aData keyWord:(NSString *)kegword;
- (NSDictionary *)fetchLogsAtIndex:(NSInteger)index;
- (NSArray *)fetchLogCollections;

@end
