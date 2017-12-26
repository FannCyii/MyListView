//
//  UICollectionView+KIVDS.h
//  Demolibrarys
//
//  Created by kivan on 13/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KIVCVBaseItem.h"

@interface UICollectionView (KIVDS)

- (void)registerItem:(KIVCVBaseItem *)item;
- (void)registerItmes:(NSArray<KIVCVBaseItem *> *)items;

@end
