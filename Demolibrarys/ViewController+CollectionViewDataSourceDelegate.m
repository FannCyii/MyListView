//
//  ViewController+CollectionViewDataSourceDelegate.m
//  Demolibrarys
//
//  Created by kivan on 17/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "ViewController+CollectionViewDataSourceDelegate.h"

#import "AddArticleVC.h"

@interface ViewController ()

@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) KIVCollectionViewProtocol * dataSource;

@end

@implementation ViewController (CollectionViewDataSourceDelegate)

- (void)handleMainData
{
    KIVCVCellSection *section = [KIVCVCellSection new];
    
//    KIVCVBaseItem *item = [KIVCVBaseItem new];
//    item.cellClassName = @"KIVHomeCVHeaderCell";
//    item.height = 100;
//    item.with = [UIScreen mainScreen].bounds.size.width - 10;
//    item.rowColor = [UIColor yellowColor];
//    [array addObject:item];
    
    KIVCVCellItem *item = [KIVCVCellItem new];
    item.itemClassName = @"KIVHomeCVHeaderADCell";
    item.height = 58;
    item.width = [UIScreen mainScreen].bounds.size.width;
    item.selectedHandleBlock = ^(id data, id list, NSIndexPath *indexPath) {
        [self addLogsAlert];
    };
    [section addItem:item];
    
    KIVCVCellItem *middelItem = [KIVCVCellItem new];
    middelItem.itemClassName = @"KIVHomeCVMiddelCell";
    middelItem.height = 100;
    middelItem.width = [UIScreen mainScreen].bounds.size.width;
    middelItem.itemColor = [UIColor whiteColor];
    middelItem.canNotSelected = YES;
    middelItem.delegateTarget = self;
    [section addItem:middelItem];
    
    
//    KIVCVBaseItem *userInfoItem = [KIVCVBaseItem new];
//    userInfoItem.cellClassName = @"KIVHomeCVUserCell";
//    userInfoItem.height = 110;
//    userInfoItem.with = [UIScreen mainScreen].bounds.size.width;
//    userInfoItem.rowColor = [UIColor yellowColor];
//    [array addObject:userInfoItem];
    
    //    KIVHomeCVReadHistoryCell
    KIVCVCellItem *historiesItem = [KIVCVCellItem new];
    historiesItem.itemClassName = @"KIVHomeCVReadHistoryCell";
    historiesItem.height = 80 * 10;
    historiesItem.width = [UIScreen mainScreen].bounds.size.width;
    historiesItem.itemColor = [UIColor colorWithWhite:0.9 alpha:0.7];
    [section addItem:historiesItem];

    [self.collectionView registeKivProtocol:self.dataSource];
    [self.collectionView addSection:section];
    [self.collectionView kiv_reloadData];
}

- (void)addLogsAlert
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *addLogsAtcion = [UIAlertAction actionWithTitle:@"导入日志" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[KIVRouter sharedInstance] routeToModulesOfKey:@"importlogvc"];
    }];
    
    UIAlertAction *addArticleAtcion = [UIAlertAction actionWithTitle:@"添加文章" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AddArticleVC *addVc = [AddArticleVC new];
        [self.navigationController pushViewController:addVc animated:YES];
    }];
    
    UIAlertAction *enterAnction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVc addAction:addLogsAtcion];
    [alertVc addAction:addArticleAtcion];
    [alertVc addAction:enterAnction];
    
    [self presentViewController:alertVc animated:YES completion:nil];
}

@end
