//
//  KIVTableViewProtocol.m
//  Demo_AboutList
//
//  Created by Fann on 17/01/2018.
//  Copyright © 2018 Fann. All rights reserved.
//

#import "KIVTableViewProtocol.h"
#import "KIVBaseCellInterface.h"
#import "UITableView+KIVListHandle.h"

@interface KIVTableViewProtocol()
@property (nonatomic, strong) NSMutableArray<KIVTVCellSection *> *dataArray;
@end


@implementation KIVTableViewProtocol

#pragma mark - Update
- (void)updateWithData:(NSArray <KIVTVCellSection *> *)sections
{
    self.dataArray = sections.mutableCopy;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    KIVTVCellSection *cellSection = [self.dataArray objectAtIndex:section];
    return cellSection.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KIVTVCellSection *cellSection = [self.dataArray objectAtIndex:indexPath.section];
    KIVTVCellItem *cellItem = [cellSection.items objectAtIndex:indexPath.item];
    
    UITableViewCell <KIVBaseCellInterface> *cell = [tableView dequeueReusableCellWithIdentifier:cellItem.itemIdentifier forIndexPath:indexPath];
    
    if ([cell respondsToSelector:@selector(updataCellWithItemData:)]) {
        [cell updataCellWithItemData:cellItem.itemData];
    }else if ([cell respondsToSelector:@selector(updateCellWithItem:)]) {
        [cell updateCellWithItem:cellItem];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KIVTVCellSection *section = [[tableView sections] objectAtIndex:indexPath.section];
    KIVTVCellItem *row = [section.items objectAtIndex:indexPath.row];
    if(row.height < 0.1){
        return 45;
    }
    return row.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    KIVTVCellSection *sec = [[tableView sections] objectAtIndex:section];
    if(sec.height < 0.1){
        return 0.01;
    }
    return sec.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    KIVTVCellSection *sec = [[tableView sections] objectAtIndex:section];
    if(sec.height < 0.1){
        return 0.01;
    }
    return sec.height;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KIVTVCellSection *section = [[tableView sections] objectAtIndex:indexPath.section];
    KIVTVCellItem *row = [section.items objectAtIndex:indexPath.row];
    if(!row.canNotSelected){
        //优先条用row的点击事件
        if(row.selectedHandleBlock){
            row.selectedHandleBlock(row.itemData, tableView, indexPath);
        }else if(section.selectedHandleBlock){
            section.selectedHandleBlock(row.itemData, tableView, indexPath);
        }
        UITableViewCell<KIVBaseCellInterface> *cell = [tableView cellForRowAtIndexPath:indexPath];
        if ([cell respondsToSelector:@selector(didSeletedWithData:withIndexPath:ofList:)]) {
            [cell didSeletedWithData:row.itemData withIndexPath:indexPath ofList:tableView];
        }
    }
}

@end
