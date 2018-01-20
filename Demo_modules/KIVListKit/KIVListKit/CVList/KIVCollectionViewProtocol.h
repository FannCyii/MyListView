//
//  KIVCollectionViewProtocol.h
//  Demo_AboutList
//
//  Created by Fann on 16/01/2018.
//  Copyright © 2018 Fann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KIVCVCellItem.h"
#import "KIVCVCellSection.h"
//#import "UICollectionView+KIVListHandle.h"

@interface KIVCollectionViewProtocol : NSObject <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

- (void)updateWithData:(NSArray <KIVCVCellSection *> *)sections;

@end
