//
//  UITableView+KIVDS.m
//  Demo_TableView
//
//  Created by kivan on 23/11/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "UITableView+KIVDS.h"
#import "KIVDSBaseSection.h"
#import "KIVDSBaseRow.h"
#import "KIVDSBaseTVCell.h"

#import <objc/runtime.h>

@implementation UITableView (KIVDS)

+ (void)load{
    
}


//datas
- (void)setKivSections:(NSMutableArray<KIVDSBaseSection *> *)sections
{
    return objc_setAssociatedObject(self, @selector(kivSections), sections, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableArray <KIVDSBaseSection *> *)kivSections
{
    return objc_getAssociatedObject(self, _cmd);
}

//datasouce
- (KIVDSDataSource *)kivDataSource
{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setKivDataSource:(KIVDSDataSource *)dataSource
{
    return objc_setAssociatedObject(self, @selector(kivDataSource), dataSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - 数据更新 与 清除
- (void)refreshData
{
    [self.kivDataSource connectDataWithSections:self.kivSections];
    [self reloadData];
}

- (void)clearData
{
    KIVDSDataSource *dataSource = [self kivDataSource];
    [dataSource connectDataWithSections:nil];
    [self reloadData];
}

//注册
- (void)registerKivDataSource:(KIVDSDataSource *)dataSource
{
    [self setKivDataSource:dataSource];
    
    self.delegate = dataSource;
    self.dataSource = dataSource;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - 注册cell
- (void)registerCellWithRow:(KIVDSBaseRow *)row
{
    if (row.cellClassName) {
        UINib *nib = [UINib nibWithNibName:row.cellClassName bundle:nil];
        if(nib){
            [self registerNib:nib forCellReuseIdentifier:row.cellIdentifier];
        }else{
            Class cellClass = NSClassFromString(row.cellClassName);
            if(cellClass){
                [self registerClass:cellClass forCellReuseIdentifier:row.cellIdentifier];
            }
        }
    }else{
        [self registerClass:NSClassFromString(@"KIVDSBaseTVCell") forCellReuseIdentifier:BASE_CELL_IDENTIFIER];
    }
}

#pragma mark - 添加数据
- (void)addSection:(KIVDSBaseSection *)section
{
    if(section){
        if(!self.kivSections){
            self.kivSections = [NSMutableArray array];
        }
        [self.kivSections addObject:section];
        for (KIVDSBaseRow *row in section.rows) {
            [self registerCellWithRow:row];
        }
    }
}

- (void)addSections:(NSArray <KIVDSBaseSection *>*)sections
{
    for (KIVDSBaseSection *sectionItem in sections) {
        [self addSection:sectionItem];
    }
}


#pragma mark - 行数据处理
- (KIVDSBaseRow *)getRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section > self.kivSections.count){
        return nil;
    }
    KIVDSBaseSection *dsSection = [self.kivSections objectAtIndex:indexPath.section];
    if(indexPath.row > dsSection.rows.count){
        return nil;
    }
    return [dsSection.rows objectAtIndex:indexPath.row];
}


- (void)updateCellWithData:(id)data atIndexPath:(NSIndexPath *)indexPath
{
    KIVDSBaseTVCell *cell = [self cellForRowAtIndexPath:indexPath];
    KIVDSBaseRow *row = [self getRowAtIndexPath:indexPath];
    row.cellData = data;
    [cell updateDataWithData:row.cellData];
}

@end
