//
//  UICollectionView+KIVDS.m
//  Demolibrarys
//
//  Created by kivan on 13/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "UICollectionView+KIVDS.h"
#import <objc/runtime.h>

NSString * const BASE_CVCELL_IDENTIFIER = @"UICollectionViewCell";


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
        item.cellClassName = @"KIVBaseCVCell";
        [self registerClass:NSClassFromString(item.cellClassName) forCellWithReuseIdentifier:item.cellClassName];
    }
}

- (void)registerItmes:(NSArray<KIVCVBaseItem *> *)items
{
    for (KIVCVBaseItem *item in items) {
        [self registerItem:item];
    }
}

#pragma  mark - DataHolder

- (void)setCollectionViewSections:(NSArray *)sections
{
    return objc_setAssociatedObject(self, @selector(kivSections), sections, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSArray *)collectionViewSections
{
    return objc_getAssociatedObject(self, _cmd);
}


@end
