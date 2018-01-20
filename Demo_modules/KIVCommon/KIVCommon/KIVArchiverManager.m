//
//  KIVArchiverManager.m
//  Demolibrarys
//
//  Created by Fann on 28/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "KIVArchiverManager.h"

const NSString *LOGSTITLE = @"title";
const NSString *LOGSCONTENT = @"content";


@interface KIVArchiverManager()
@property (nonatomic, strong) NSString  *archiveIdentifior;
@end

@implementation KIVArchiverManager

- (instancetype)initWithIdentifior:(NSString *)identifior
{
    return [self initWithIdentifior:identifior completeHandle:nil];
}

- (instancetype)initWithIdentifior:(NSString *)identifior completeHandle:(KIVArchiverSaveCompleteBlock)completeHandle;
{
    self = [super init];
    if (self) {
        self.archiveIdentifior = identifior;
        self.saveCompleteBlock = completeHandle;
    }
    return self;
}

- (void)saveLogs:(id)aData keyWord:(NSString *)kegword
{
    NSDictionary *archerParam = @{LOGSTITLE:kegword,
                                  LOGSCONTENT:aData
                                  };
    [self insertLogLogCollectionWithData:archerParam];
}

//- (NSDictionary *)fetchLogsAtIndex:(NSInteger)index
//{
//    NSArray *array = [self getAllLogs];
//    if (array.count < index) {
//        return nil;
//    }
//    return [array objectAtIndex:index];
//}

#pragma mark insert and fetch
- (void)insertLogLogCollectionWithData:(NSDictionary *)aData
{
    NSMutableArray *array = [[self getAllLogs] mutableCopy];
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:array];
//    if (array.count == 0) {
//        array = [NSMutableArray array];
//    }
    if (!(self.archiverType == KIVArchiverTypeOfRepeatable)) {
        for (NSDictionary *item in array) {
            if ([item[LOGSTITLE] isEqualToString:aData[LOGSTITLE]]) {
                [newArray removeObject:item];
            }
        }
    }

    [newArray addObject:aData];
    [self savelogs:newArray];
}

#pragma mark - 最终的存储操作
- (void)savelogs:(id)aData
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = nil;
        if (![aData isKindOfClass:[NSData class] ]) {
            data = [NSKeyedArchiver archivedDataWithRootObject:aData];
        }else{
            data = aData;
        }
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:self.archiveIdentifior];
        if (self.saveCompleteBlock) {
            self.saveCompleteBlock();
        }
    });
}

- (NSArray *)getAllLogs
{
    NSData *aData = [[NSUserDefaults standardUserDefaults] objectForKey:self.archiveIdentifior];
    NSArray *logs = (NSArray *)[NSKeyedUnarchiver unarchiveObjectWithData:aData];
    return logs;
}

- (id)getLogWithIndex:(NSUInteger)index
{
    NSArray *array = [self getAllLogs];
    if (array.count < index) {
        return nil;
    }
    return [array objectAtIndex:index];
}

- (BOOL)capacityHandle:(id)logItem
{
    NSArray *array = [self getAllLogs];
    if (array.count >= self.capacity) {
        
    }
    
    if (self.archiverType == KIVArchiverTypeOfRepeatable) {
        //可重复
        
    }else if(self.archiverType == KIVArchiverTypeOfUnique){
        //不可重复
        //移除旧值
    }
    
    return NO;
}

- (void)insertLog:(id)logItem
{
    [self capacityHandle:logItem];
    [self insertLog:logItem];
}

- (void)insertlogs:(NSArray *)logs
{
    for (id item in logs) {
        [self insertLog:item];
    }
}


@end
