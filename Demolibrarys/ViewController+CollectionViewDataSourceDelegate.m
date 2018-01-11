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

#import "AddArticleVC.h"

@interface ViewController ()

@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) KIVCVDataSource * dataSource;

@end

@implementation ViewController (CollectionViewDataSourceDelegate)

- (void)handleMainData
{
    NSMutableArray *array = [NSMutableArray array];

//    KIVCVBaseItem *item = [KIVCVBaseItem new];
//    item.cellClassName = @"KIVHomeCVHeaderCell";
//    item.height = 100;
//    item.with = [UIScreen mainScreen].bounds.size.width - 10;
//    item.rowColor = [UIColor yellowColor];
//    [array addObject:item];
    
    KIVCVBaseItem *item = [KIVCVBaseItem new];
    item.cellClassName = @"KIVHomeCVHeaderADCell";
    item.height = 58;
    item.with = [UIScreen mainScreen].bounds.size.width;
    item.selectedBlock = ^(id listView, NSIndexPath *indexPath) {
        [self addLogsAlert];
    };
    [array addObject:item];
    
    KIVCVBaseItem *middelItem = [KIVCVBaseItem new];
    middelItem.cellClassName = @"KIVHomeCVMiddelCell";
    middelItem.height = 100;
    middelItem.with = [UIScreen mainScreen].bounds.size.width;
    middelItem.rowColor = [UIColor whiteColor];
    [array addObject:middelItem];
    
    
//    KIVCVBaseItem *userInfoItem = [KIVCVBaseItem new];
//    userInfoItem.cellClassName = @"KIVHomeCVUserCell";
//    userInfoItem.height = 110;
//    userInfoItem.with = [UIScreen mainScreen].bounds.size.width;
//    userInfoItem.rowColor = [UIColor yellowColor];
//    [array addObject:userInfoItem];
    
    //    KIVHomeCVReadHistoryCell
    KIVCVBaseItem *historiesItem = [KIVCVBaseItem new];
    historiesItem.cellClassName = @"KIVHomeCVReadHistoryCell";
    historiesItem.height = 80 * 10;
    historiesItem.with = [UIScreen mainScreen].bounds.size.width;
    historiesItem.rowColor = [UIColor colorWithWhite:0.9 alpha:0.7];
    [array addObject:historiesItem];
    

    
    [self.collectionView registerItmes:array];
    self.dataSource.itemArray = array;
    [self.collectionView reloadData];
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
