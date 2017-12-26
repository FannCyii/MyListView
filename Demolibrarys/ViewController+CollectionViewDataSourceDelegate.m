//
//  ViewController+CollectionViewDataSourceDelegate.m
//  Demolibrarys
//
//  Created by kivan on 17/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "ViewController+CollectionViewDataSourceDelegate.h"
#import "KIVCVDataSource.h"
#import "KIVCVBaseSection.h"
#import "KIVCVBaseItem.h"
#import "UICollectionView+KIVDS.h"

@interface ViewController ()

@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) KIVCVDataSource * dataSource;

@end

@implementation ViewController (CollectionViewDataSourceDelegate)

- (void)handleMainData
{
    NSMutableArray *array = [NSMutableArray array];

    KIVCVBaseItem *item = [KIVCVBaseItem new];
    item.cellClassName = @"KIVHomeCVHeaderCell";
    item.height = 100;
    item.with = [UIScreen mainScreen].bounds.size.width - 10;
    item.rowColor = [UIColor yellowColor];
    [array addObject:item];
    
    KIVCVBaseItem *middelItem = [KIVCVBaseItem new];
    middelItem.cellClassName = @"KIVHomeCVMiddelCell";
    middelItem.height = 400;
    middelItem.with = [UIScreen mainScreen].bounds.size.width - 10;
    middelItem.rowColor = [UIColor whiteColor];
    [array addObject:middelItem];
    
    [self.collectionView registerItmes:array];
    self.dataSource.itemArray = array;
    [self.collectionView reloadData];
}

@end
