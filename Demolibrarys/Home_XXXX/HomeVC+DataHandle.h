//
//  HomeVC+DataHandle.h
//  Demolibrarys
//
//  Created by kivan on 13/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "HomeVC.h"

typedef NS_ENUM(NSUInteger, HomeCellType) {
    HomeListCellType,
    HomeItemCellType,
};

@interface HomeVC (DataHandle)
- (void)refreshCollectionViewWihtType:(HomeCellType)type;
@end
