//
//  UICollectionView+KIVDS.m
//  Demolibrarys
//
//  Created by kivan on 13/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "UICollectionView+KIVDS.h"

NSString * const BASE_CVCELL_IDENTIFIER = @"KIVVCBaseVCCell_Base";


@implementation UICollectionView (KIVDS)

- (void)registerItem:(KIVCVBaseItem *)item
{
    if (item.cellClassName) {
        UINib *nib = [UINib nibWithNibName:item.cellClassName bundle:nil];
        if(nib && !([item.cellClassName isEqualToString:@"UICollectionViewCell"])){
            [self registerNib:nib forCellWithReuseIdentifier:item.cellIdentifier];
        }else{
            Class cellClass = NSClassFromString(item.cellClassName);
            if(cellClass){
                [self registerClass:cellClass forCellWithReuseIdentifier:item.cellIdentifier];
            }
        }
    }else{
        [self registerClass:NSClassFromString(@"UICollectionViewCell") forCellWithReuseIdentifier:BASE_CVCELL_IDENTIFIER];
    }
}

- (void)registerItmes:(NSArray<KIVCVBaseItem *> *)items
{
    for (KIVCVBaseItem *item in items) {
        [self registerItem:item];
    }
}

@end
