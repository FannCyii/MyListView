//
//  KIVCVDataSource.h
//  Demolibrarys
//
//  Created by kivan on 13/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICollectionView+KIVDS.h"
#import "KIVBaseCVCell.h"

@class KIVCVDataSource;
@protocol KIVCVDataSourceDelegate <NSObject>
- (id)getTargetVCWihtDataSource:(KIVCVDataSource *)dataSource;
@end

@interface KIVCVDataSource : NSObject <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic, weak) id<KIVCVDataSourceDelegate> delegate;
@property (nonatomic, strong) NSArray *itemArray;

@end
