//
//  KIVArchiverManager.m
//  Demolibrarys
//
//  Created by Fann on 28/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "KIVArchiverManager.h"
#import "DataParser.h"

const NSString *LOGSTITLE = @"title";
const NSString *LOGSCONTENT = @"content";

@interface KIVArchiverManager()
@property (nonatomic, strong) NSString  *archiveIdentifior;
@end

@implementation KIVArchiverManager

- (instancetype)initWithIdentifior:(NSString *)identifior
{
    self = [super init];
    if (self) {
        self.archiveIdentifior = identifior;
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

- (NSDictionary *)fetchLogsAtIndex:(NSInteger)index
{
    NSArray *array = [self fetchLogCollections];
    if (array.count < index) {
        return nil;
    }
    return [array objectAtIndex:index];
}


#pragma mark insert and fetch
- (NSArray *)fetchLogCollections
{
    NSData *aData = [[NSUserDefaults standardUserDefaults] objectForKey:self.archiveIdentifior];
    NSArray *logCollections = (NSArray *)[NSKeyedUnarchiver unarchiveObjectWithData:aData];
    return logCollections;
}

- (void)insertLogLogCollectionWithData:(NSDictionary *)aData
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *array = [[self fetchLogCollections] mutableCopy];
        if (array.count == 0) {
            array = [NSMutableArray array];
        }
        for (NSDictionary *item in array) {
            if ([item[LOGSTITLE] isEqualToString:aData[LOGSTITLE]]) {
                [array removeObject:item];
            }
        }
        [array addObject:aData];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:self.archiveIdentifior];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_ARCHIVER_LOGS object:nil];
    });
}



@end
