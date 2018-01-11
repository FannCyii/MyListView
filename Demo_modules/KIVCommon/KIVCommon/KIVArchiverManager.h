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

typedef void (^KIVArchiverSaveCompleteBlock)(void);

typedef NS_ENUM(NSInteger,KIVArchiverType) {
    KIVArchiverTypeOfDefault = 0,
    KIVArchiverTypeOfUnique = 0,
    KIVArchiverTypeOfRepeatable,
};


@interface KIVArchiverManager : NSObject

@property (nonatomic, assign) KIVArchiverType archiverType;
@property (nonatomic, assign) NSUInteger capacity;
@property (nonatomic, copy) KIVArchiverSaveCompleteBlock saveCompleteBlock;

- (instancetype)initWithIdentifior:(NSString *)identifior;
- (instancetype)initWithIdentifior:(NSString *)identifior completeHandle:(KIVArchiverSaveCompleteBlock)completeHandle;

/**
 以键值对的形式存储

 @param aData 值
 @param kegword 键
 */
- (void)saveLogs:(id)aData keyWord:(NSString *)kegword;
- (void)insertlogs:(NSArray *)logs;
- (void)insertLog:(id)logItem;

- (NSArray *)getAllLogs;
- (id)getLogWithIndex:(NSUInteger)index;




@end
