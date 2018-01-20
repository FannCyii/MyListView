//
//  KIVTableViewProtocol.m
//  Demo_AboutList
//
//  Created by Fann on 17/01/2018.
//  Copyright © 2018 Fann. All rights reserved.
//

#import "KIVTableViewProtocol.h"
#import "KIVBaseCellInterface.h"

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

@end
