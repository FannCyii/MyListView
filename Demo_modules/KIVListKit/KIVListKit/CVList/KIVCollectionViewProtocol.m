//
//  KIVCollectionViewProtocol.m
//  Demo_AboutList
//
//  Created by Fann on 16/01/2018.
//  Copyright © 2018 Fann. All rights reserved.
//

#import "KIVCollectionViewProtocol.h"
#import "KIVBaseCellInterface.h"

@interface KIVCollectionViewProtocol()
@property (nonatomic, strong) NSMutableArray<KIVCVCellSection *> *dataArray;
@end

@implementation KIVCollectionViewProtocol


#pragma mark - Initialize
//- (void)registeWithCollectionView:(UICollectionView *)collectionView
//{
//    collectionView.delegate = self;
//    collectionView.dataSource = self;
//
//}

#pragma mark - Update
- (void)updateWithData:(NSArray <KIVCVCellSection *> *)sections
{
    self.dataArray = sections.mutableCopy;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    KIVCVCellSection *cellSection = [self.dataArray objectAtIndex:section];
    return cellSection.items.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KIVCVCellSection *cellSection = [self.dataArray objectAtIndex:indexPath.section];
    KIVCVCellItem *cellItem = [cellSection.items objectAtIndex:indexPath.item];
    
    UICollectionViewCell<KIVBaseCellInterface> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellItem.itemIdentifier forIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(updateCellWithItem:)]) {
        [cell updateCellWithItem:cellItem];
    }else if([cell respondsToSelector:@selector(updataCellWithItemData:)]){
        [cell updataCellWithItemData:cellItem.itemData];
    }
    
    if(cellItem.itemColor){
        cell.backgroundColor = cellItem.itemColor;
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

#warning @"这里有待优化，应该使用UICollectionViewDelegate 来实现"
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KIVCVCellSection *cellSection = [self.dataArray objectAtIndex:indexPath.section];
    KIVCVCellItem *cellItem = [cellSection.items objectAtIndex:indexPath.item];
    NSLog(@"[WARNING]The size of item(%@) is invalid,height or width may 0",cellItem);
    return CGSizeMake(cellItem.itemWidth, cellItem.itemHeight);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    KIVCVCellSection *cellSection = [self.dataArray objectAtIndex:indexPath.section];
    KIVCVCellItem *cellItem = [cellSection.items objectAtIndex:indexPath.item];
    
    if (cellItem.selectedHandleBlock) {
        cellItem.selectedHandleBlock(cellSection, collectionView, indexPath);
    }else if (cellSection.selectedHandleBlock) {
        cellSection.selectedHandleBlock(cellSection, collectionView, indexPath);
    }
    
    UICollectionViewCell<KIVBaseCellInterface> *cell = [collectionView cellForItemAtIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(didSeletedWithData:withIndexPath:ofList:)]) {
        [cell didSeletedWithData:cellItem withIndexPath:indexPath ofList:collectionView];
    }
}
@end
