//
//  KIVDSBaseSection.m
//  HomePage
//
//  Created by kivan on 02/11/2017.
//  Copyright © 2017 HomePage. All rights reserved.
//

#import "KIVDSBaseSection.h"

@interface KIVDSBaseSection ()
@property (nonatomic, strong) NSMutableArray<KIVDSBaseRow *> *rows;
@end

@implementation KIVDSBaseSection
- (NSMutableArray *)rows
{
    if(!_rows){
        _rows = [NSMutableArray array];
    }
    return _rows;
}

#pragma mark -Insert & remove
- (void)insertRow:(KIVDSBaseRow *)row
{
    if(row){
        [self.rows addObject:row];
    }
    
}
- (void)insertFirsteRow:(KIVDSBaseRow *)row
{
    [self insertRow:row atIndex:0];
}

- (void)insertAtLastRow:(KIVDSBaseRow *)row
{
    if(self.rows.count == 0){
        [self insertRow:row];
    }else{
        [self insertRow:row atIndex:self.rows.count];
    }
}

- (void)insertRow:(KIVDSBaseRow *)row atIndex:(NSUInteger)index
{
    if(row && index <= self.rows.count){
        [self.rows insertObject:row atIndex:index];
    }
}
- (void)insertRows:(NSArray<KIVDSBaseRow *> *)rows
{
    for (KIVDSBaseRow *row in rows) {
        [self insertRow:row];
    }
}

- (void)clearRows
{
    [self.rows removeAllObjects];
}

- (void)removeRow:(KIVDSBaseRow *)row
{
    [self.rows removeObject:row];
}

- (void)removeRowAtIndex:(NSUInteger)rowIndex
{
    [self.rows removeObjectAtIndex:rowIndex];
}

#pragma mark - 批处理

- (void)addTemplateRow:(KIVDSBaseRow *)row withArrayData:(NSArray *)data
{
    for (id itemData in data) {
        KIVDSBaseRow *itemRow = [KIVDSBaseRow new];
        itemRow.cellData = itemData;
        itemRow.rowHeight = row.rowHeight;
        itemRow.rowColor = row.rowColor;
        itemRow.hiddenRowBottomLine = row.hiddenRowBottomLine;
        itemRow.canNotSelected = row.canNotSelected;
        itemRow.cellClassName = row.cellClassName;
        [self insertRow:itemRow];
    }
}



@end
