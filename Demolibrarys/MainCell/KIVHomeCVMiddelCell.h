//
//  KIVHomeCVMiddelCell.h
//  Demolibrarys
//
//  Created by kivan on 17/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KIVHomeCVMiddelCell;
@protocol KIVHomeCVMiddelCellDelegate <NSObject>

@optional
- (void)kivHomeCVMiddelCell:(KIVHomeCVMiddelCell *)cell selectedIndexPath:(NSIndexPath *)indexPath;
- (void)kivHomeCVMiddelCell:(KIVHomeCVMiddelCell *)cell selectedIndexPath:(NSIndexPath *)indexPath cellData:(id)aData;
@end

@interface KIVHomeCVMiddelCell : UICollectionViewCell <KIVBaseCellInterface>

@property (nonatomic, weak) id<KIVHomeCVMiddelCellDelegate> delegate;

@end
