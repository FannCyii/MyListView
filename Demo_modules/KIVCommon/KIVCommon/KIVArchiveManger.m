//
//  KIVArchiveManger.m
//  KIVCommon
//
//  Created by Fann on 11/01/2018.
//  Copyright © 2018 Fann. All rights reserved.
//

#import "KIVArchiveManger.h"

const NSString *ArchiveValue = @"ArchiveValue";
const NSString *ArchiveKey = @"ArchiveKey";

@interface KIVArchiveManger()

@property (nonatomic, strong) NSString *archiveIdentifier;

//@property (nonatomic, strong) NSMutableArray identifiers;
//@property (nonatomic, strong) NSMutableArray * completeHandleArray;
@end


@implementation KIVArchiveManger

//+ (instancetype)sharedInstance {
//    static KIVArchiveManger *sharedInstance = nil;
//    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        sharedInstance = [[KIVArchiveManger alloc] init];
//    });
//    
//    return sharedInstance;
//}

//#pragma mark - Accessor
//- (NSMutableArray *)identifiers
//{
//    if (!_identifiers) {
//        _identifiers = [NSMutableArray array];
//    }
//    return _identifiers;
//}
//
//- (NSMutableArray *)completeHandleArray
//{
//    if (!_completeHandleArray) {
//        _completeHandleArray = [NSMutableArray array];
//    }
//    return _completeHandleArray;
//}

#pragma mark - Register
- (void)registeWithIdentifier:(NSString *)identifier
{
    [self registeWithIdentifier:identifier completeBlock:nil];
}

- (void)registeWithIdentifier:(NSString *)identifier completeBlock:(KIVArchiveCompleteBlock)completeBlock
{
    if (identifier.length == 0) {
        return ;
    }
//    if ([self.identifiers containsObject:identifier]) {
//        NSLog(@"The identifier(\"%@\") is have registed! change another one",identifier);
//        return NO;
//    }
//    [self.identifiers addObject:identifier];
    self.archiveIdentifier = identifier;
    if (completeBlock) {
        self.completeBlock = completeBlock;
    }
    
}

//- (KIVArchiveCompleteBlock)completeBlockForIdentifier:(NSString *)identifier
//{
//    KIVArchiveCompleteBlock completetBlock = nil;
//    for (NSDictionary *dir in self.identifiers) {
//        if ([[dir.allKeys firstObject] isEqualToString:identifier]) {
//            completetBlock = [dir.allValues firstObject];
//            break ;
//        }
//    }
//    return completetBlock;
//}

#pragma mark - 最终的存储操作
- (void)saveData:(id)aData
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = nil;
        if (![aData isKindOfClass:[NSData class] ]) {
            data = [NSKeyedArchiver archivedDataWithRootObject:aData];
        }else{
            data = aData;
        }
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:self.archiveIdentifier];

        if (self.completeBlock) {
            self.completeBlock();
        }
    });
}

- (void)saveValue:(id)aData withKey:(NSString *)keyword
{
    NSDictionary *dir = @{
                          ArchiveKey:keyword,
                          ArchiveValue:aData
                          };
    [self saveData:dir];
    
}


@end
