//
//  UICollectionView+KIVListHandle.h
//  Demo_AboutList
//
//  Created by Fann on 16/01/2018.
//  Copyright © 2018 Fann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KIVCollectionViewProtocol.h"

@interface UICollectionView (KIVListHandle)

- (NSMutableArray *)sections;

//register
- (void)registeKivProtocol:(KIVCollectionViewProtocol *)kivProtocol;

//update and refresh
- (void)kiv_reloadData;
- (void)reloadCellWithData:(id)data atIndexPath:(NSIndexPath *)indexPath;
- (void)updateItemWithNew:(KIVCVCellItem *)newItem atIndexPath:(NSIndexPath *)indexPath;

//data getter and setter
- (void)addSections:(NSMutableArray *)sections;
- (void)addSection:(KIVCVCellSection *)section;
- (void)addSection:(KIVCVCellSection *)section atIndex:(NSInteger)index;
- (void)addItem:(KIVCVCellItem *)item atIndexPath:(NSIndexPath *)indexPath;


@end
