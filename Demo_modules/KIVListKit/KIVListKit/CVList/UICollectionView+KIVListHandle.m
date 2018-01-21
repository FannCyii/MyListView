//
//  UICollectionView+KIVListHandle.m
//  Demo_AboutList
//
//  Created by Fann on 16/01/2018.
//  Copyright © 2018 Fann. All rights reserved.
//

#import "UICollectionView+KIVListHandle.h"
#import <objc/runtime.h>
#import "KIVTableViewProtocol.h"
#import "KIVBaseCellInterface.h"

@implementation UICollectionView (KIVListHandle)
//sections
- (NSMutableArray *)sections
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSections:(NSMutableArray<KIVCVCellSection *> *)sections
{
    [self registeWithSecions:sections];
    objc_setAssociatedObject(self, @selector(sections), sections, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//kivProtocol
- (KIVCollectionViewProtocol *)kivProtocol
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setKivProtocol:(KIVCollectionViewProtocol *)protocol
{
    objc_setAssociatedObject(self, @selector(kivProtocol), protocol, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Register
- (void)registeItem:(KIVCVCellItem *)item
{
//    if ([item.itemClassName isEqualToString:@"UICollectionViewCell"]) {
//        [self registerClass:NSClassFromString(item.itemClassName) forCellWithReuseIdentifier:item.itemIdentifier];
//        return;
//    }
//
    if(item.itemClassName.length == 0){
        NSLog(@"[ERROR] item <%@> 's itemClassName can not be nil!",item);
        return;
    }
#warning @"这里需要修改，直接这样使用nib有问题"
    //如果存在nib 则优先使用nib
    if ([[NSBundle mainBundle] pathForResource:item.itemClassName ofType:@"nib"] != nil) {
        UINib *nib = [UINib nibWithNibName:item.itemClassName bundle:nil];
        [self registerNib:nib forCellWithReuseIdentifier:item.itemIdentifier];
    }else{
        [self registerClass:NSClassFromString(item.itemClassName) forCellWithReuseIdentifier:item.itemIdentifier];
    }
}

- (void)registeSection:(KIVCVCellSection *)section
{
    for (KIVCVCellItem *item in section.items) {
        [self registeItem:item];
    }
}

- (void)registeWithSecions:(NSArray *)sections
{
    for (KIVCVCellSection *section in sections) {
        [self registeSection:section];
    }
}

- (void)registeKivProtocol:(KIVCollectionViewProtocol *)protocol
{
    self.delegate = protocol;
    self.dataSource = protocol;
    [self setKivProtocol:protocol];
}

#pragma mark -Update Data & Refresh Data
- (void)kiv_reloadData
{
    [[self kivProtocol] updateWithData:[self sections]];
    [self reloadData];
}

//这里不能替换cell 只能更新cell中的数据，所以是否考虑将data为KIVCVCellItem 情况去掉，更新cell只能用全局更新才行
- (void)reloadCellWithData:(id)data atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell <KIVBaseCellInterface> *cell = [self cellForItemAtIndexPath:indexPath];
    #warning @"这里只能做data的更新，而状态的更新需要修改，如copy item整体是是否是深拷贝,而且这里需要更新collectionview的section中对应的item"
    if ([data isKindOfClass:[KIVCVCellItem class]]) {
        if ([cell respondsToSelector:@selector(updateCellWithItem:)]){
            KIVCVCellItem *newItem = data;
            [self updateItemWithNew:data atIndexPath:indexPath];
            [cell updateCellWithItem:newItem];
        }else{
            NSLog(@"[ERROR]The cell<%@> dosen't compliance the interface <KIVBaseCellInterface>",cell);
        }
    }else{
        if ([cell respondsToSelector:@selector(updataCellWithItemData:)]) {
            KIVCVCellItem *row = [self getRowAtIndexPath:indexPath];
            row.itemData = data;
            [cell updataCellWithItemData:row.itemData];
        }else {
            NSLog(@"[ERROR]The cell<%@> dosen't compliance the interface <KIVBaseCellInterface>",cell);
        }
    }
}

//这里是更新数据,防止cell重用导致cell数据不一致
- (void)updateItemWithNew:(KIVCVCellItem *)newItem atIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray<KIVCVCellSection *> *sections = [self sections].mutableCopy;
    KIVCVCellSection *section = [sections objectAtIndex:indexPath.section];
    [section.items replaceObjectAtIndex:indexPath.item withObject:newItem];
    [sections replaceObjectAtIndex:indexPath.section withObject:section];
    [self setSections:sections];
}


- (void)addSections:(NSMutableArray *)sections
{
    [self setSections:sections];
}

- (void)addSection:(KIVCVCellSection *)section
{
    [self addSection:section atIndex:[self sections].count];
}

- (void)addSection:(KIVCVCellSection *)section atIndex:(NSInteger)index
{
    NSMutableArray *sections = [self sections];
    if (!sections) {
        sections = [NSMutableArray array];
    }
    if (index > sections.count) {
        index = sections.count;
    }
    [sections insertObject:section atIndex:index];
    [self setSections:sections];
}
- (void)addItem:(KIVCVCellItem *)item atIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *sections = [self sections];
    KIVCVCellSection *section = [sections objectAtIndex:indexPath.section];
    [section.items insertObject:item atIndex:indexPath.item];
}

- (KIVCVCellItem *)getRowAtIndexPath:(NSIndexPath *)indexPath
{
    KIVCVCellSection *cellSection = [[self sections] objectAtIndex:indexPath.section];
    return [cellSection.items objectAtIndex:indexPath.row];
}


@end
