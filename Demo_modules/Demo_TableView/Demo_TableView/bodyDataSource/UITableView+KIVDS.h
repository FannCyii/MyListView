//
//  UITableView+KIVDS.h
//  Demo_TableView
//
//  Created by kivan on 23/11/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KIVDSDataSource.h"

@class KIVDSBaseSection;
@class KIVDSDataSource;
@class KIVDSBaseRow;
@class KIVDSBaseTVCell;

@interface UITableView (KIVDS)

//这个不对外提供，为了调试简单先保留
- (NSMutableArray <KIVDSBaseSection *> *)kivSections __attribute__((deprecated("不对外提供，为了调试简单先保留")));
- (void)setKivSections:(NSMutableArray <KIVDSBaseSection *> *)sections __attribute__((deprecated));

/*
 *数据添加
 */
- (void)addSection:(KIVDSBaseSection *)section;
- (void)addSections:(NSArray <KIVDSBaseSection *>*)sections;
//在indexPath 处添加一行row
- (void)addRow:(KIVDSBaseRow *)row atIndexPath:(NSIndexPath *)indexPath;
//在indexSection 最后添加一行row
- (void)addRow:(KIVDSBaseRow *)row atSectionInIndex:(NSInteger)index;

//注册
- (void)registerKivDataSource:(KIVDSDataSource *)dataSource;
- (void)refreshData;
- (void)clearData;

//数据处理
- (KIVDSBaseRow *)getRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)updateCellWithData:(id)data atIndexPath:(NSIndexPath *)indexPath;
- (void)updataCell:(KIVDSBaseTVCell *)cell withData:(id)data;

@end
