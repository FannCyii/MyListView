//
//  KIVCVDataSource.m
//  Demolibrarys
//
//  Created by kivan on 13/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "KIVCVDataSource.h"

@implementation KIVCVDataSource

#pragma mark - UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KIVCVBaseItem *item = [self.itemArray objectAtIndex:indexPath.item];
    return CGSizeMake(item.with, item.height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    KIVCVBaseItem *item = [self.itemArray objectAtIndex:indexPath.item];
    if(item.selectedBlock){
        item.selectedBlock(collectionView, indexPath);
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KIVCVBaseItem *item = [self.itemArray objectAtIndex:indexPath.item];
    KIVBaseCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:item.cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = item.rowColor;
    if([self.delegate respondsToSelector:@selector(getTargetVCWihtDataSource:)]){
        id target = [self.delegate getTargetVCWihtDataSource:self];
        cell.delegate = target;
    }
    return cell;
}

@end
