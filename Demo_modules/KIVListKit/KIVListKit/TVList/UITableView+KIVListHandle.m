//
//  UITableView+KIVListHandle.m
//  Demo_AboutList
//
//  Created by Fann on 17/01/2018.
//  Copyright © 2018 Fann. All rights reserved.
//

#import "UITableView+KIVListHandle.h"
#import <objc/runtime.h>
#import "KIVTableViewProtocol.h"
#import "KIVBaseCellInterface.h"

@implementation UITableView (KIVListHandle)
//sections
- (NSMutableArray *)sections
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSections:(NSMutableArray<KIVTVCellSection *> *)sections
{
    [self registeWithSecions:sections];
    objc_setAssociatedObject(self, @selector(sections), sections, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//kivProtocol
- (KIVTableViewProtocol *)kivProtocol
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setKivProtocol:(KIVTableViewProtocol *)protocol
{
    objc_setAssociatedObject(self, @selector(kivProtocol), protocol, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - Register
- (void)registeItem:(KIVTVCellItem *)item
{
    //    if ([item.itemClassName isEqualToString:@"UICollectionViewCell"]) {
    //        [self registerClass:NSClassFromString(item.itemClassName) forCellWithReuseIdentifier:item.itemIdentifier];
    //        return;
    //    }
    //
    //如果存在nib 则优先使用nib  这里有问题，需要解决，之类判断nib是冲mainbundle中取得，如果不在mainbundl里如何处理？？？
    if ([[NSBundle mainBundle] pathForResource:item.itemClassName ofType:@"nib"] != nil) {
        UINib *nib = [UINib nibWithNibName:item.itemClassName bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:item.itemIdentifier];
    }else{
        [self registerClass:NSClassFromString(item.itemClassName) forCellReuseIdentifier:item.itemIdentifier];
    }
}

- (void)registeSection:(KIVTVCellSection *)section
{
    for (KIVTVCellItem *item in section.items) {
        [self registeItem:item];
    }
}

- (void)registeWithSecions:(NSArray *)sections
{
    for (KIVTVCellSection *section in sections) {
        [self registeSection:section];
    }
}

- (void)registeKivProtocol:(KIVTableViewProtocol *)protocol
{
    self.delegate = protocol;
    self.dataSource = protocol;
    [self setKivProtocol:protocol];
}

#pragma mark -Data Update & Refresh
- (void)kiv_reloadData
{
    [[self kivProtocol] updateWithData:[self sections]];
    [self reloadData];
}


/**
 刷新局部Cell

 @param data 刷新cell的数据
 @param indexPath cell的位置
 */
- (void)updateCellWithData:(id)data atIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell<KIVBaseCellInterface> *cell = [self cellForRowAtIndexPath:indexPath];
    KIVTVCellItem *row = [self getRowAtIndexPath:indexPath];
    row.itemData = data;
    if ([cell respondsToSelector:@selector(updataCellWithItemData:)]) {
        [cell updataCellWithItemData:row.itemData];
    }else if ([cell respondsToSelector:@selector(updateCellWithItem:)]){
        [cell updateCellWithItem:row];
    }else{
        NSLog(@"[ERROR]The cell<%@> dosen't compliance the interface <KIVBaseCellInterface>",cell);
    }
}

#pragma mark -Data Getter And Setter
- (void)addSections:(NSMutableArray *)sections
{
    [self setSections:sections];
}

- (KIVTVCellItem *)getRowAtIndexPath:(NSIndexPath *)indexPath
{
    KIVTVCellSection *cellSection = [[self sections] objectAtIndex:indexPath.section];
    return [cellSection.items objectAtIndex:indexPath.row];
}


@end
