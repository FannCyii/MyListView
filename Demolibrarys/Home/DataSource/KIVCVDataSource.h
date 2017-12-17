//
//  KIVCVDataSource.h
//  Demolibrarys
//
//  Created by kivan on 13/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICollectionView+KIVDS.h"

@interface KIVCVDataSource : NSObject <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *itemArray;

@end
