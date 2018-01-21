//
//  UITableView+KIVListHandle.h
//  Demo_AboutList
//
//  Created by Fann on 17/01/2018.
//  Copyright © 2018 Fann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KIVTableViewProtocol.h"
#import "KIVTVCellItem.h"
#import "KIVTVCellSection.h"

@interface UITableView (KIVListHandle)

- (NSMutableArray *)sections;

//register
- (void)registeKivProtocol:(KIVTableViewProtocol *)kivProtocol;


- (void)kiv_reloadData;

- (void)addSections:(NSMutableArray *)sections;
- (void)addSection:(KIVTVCellSection *)section;
- (void)addSection:(KIVTVCellSection *)section atIndex:(NSInteger)index;
- (void)addItem:(KIVTVCellItem *)item atIndexPath:(NSIndexPath *)indexPath;
@end
