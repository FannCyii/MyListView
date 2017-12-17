//
//  HomeVC+DataHandle.m
//  Demolibrarys
//
//  Created by kivan on 13/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "HomeVC+DataHandle.h"
#import "PureLayout.h"
#import "KIVCVDataSource.h"
#import "KIVCVBaseItem.h"
#import "KIVColor.h"
#import "KIVLogVC.h"

@interface HomeVC ()
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) KIVCVDataSource *dataDelegate;
@end

@implementation HomeVC (DataHandle)

- (NSArray *)listData
{
    CGRect screenRect = [UIScreen mainScreen].bounds;
    NSMutableArray *items = [NSMutableArray array];
    for (NSInteger i = 0; i < 100; ++i) {
        KIVCVBaseItem *item = [KIVCVBaseItem new];
        item.cellClassName = @"HomeListCell";
        item.height = 100;
        item.with = screenRect.size.width;
        item.cellData = @"哈哈哈";
        item.rowColor = [UIColor whiteColor];
        __weak typeof(self) weakself = self;
        item.selectedBlock = ^(id listView, NSIndexPath *indexPath) {
            __strong typeof(weakself)strongSelf = weakself;
            [strongSelf.navigationController pushViewController:[KIVLogVC new] animated:YES];
        };
        [items addObject:item];
    }
    
    return items;
}

- (NSArray *)itemData
{
    CGRect screenRect = [UIScreen mainScreen].bounds;
    NSMutableArray *items = [NSMutableArray array];
    for (NSInteger i = 0; i < 100; ++i) {
        KIVCVBaseItem *item = [KIVCVBaseItem new];
        item.cellClassName = @"HomeItemCell";
        item.height = screenRect.size.width/2 - 20;
        item.with = screenRect.size.width/2 - 20;
        item.cellData = @"哈哈哈";
        item.rowColor = [UIColor whiteColor];
        __weak typeof(self) weakself = self;
        item.selectedBlock = ^(id listView, NSIndexPath *indexPath) {
            __strong typeof(weakself)strongSelf = weakself;
            [strongSelf.navigationController pushViewController:[KIVLogVC new] animated:YES];
        };
        
        [items addObject:item];
    }
    
    return items;
}

- (void)refreshCollectionViewWihtType:(HomeCellType)type
{
    if(type == 0){
        [self.collectionView registerItmes:[self listData]];
        self.dataDelegate.itemArray = [self listData];
    }else if(type == 1){
        [self.collectionView registerItmes:[self itemData]];
        self.dataDelegate.itemArray = [self itemData];
    }
    
    return [self.collectionView reloadData];
}

@end
