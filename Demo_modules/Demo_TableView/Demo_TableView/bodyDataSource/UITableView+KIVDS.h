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

@interface UITableView (KIVDS)

- (NSMutableArray <KIVDSBaseSection *> *)kivSections;
- (void)setKivSections:(NSMutableArray <KIVDSBaseSection *> *)sections;

- (void)addSection:(KIVDSBaseSection *)section;
- (void)addSections:(NSArray <KIVDSBaseSection *>*)sections;

//data
- (void)registerKivDataSource:(KIVDSDataSource *)dataSource;
- (void)refreshData;
- (void)clearData;

//数据处理
- (KIVDSBaseRow *)getRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)updateCellWithData:(id)data atIndexPath:(NSIndexPath *)indexPath;

@end
