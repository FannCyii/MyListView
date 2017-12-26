//
//  KIVHomeCVMiddelCell.h
//  Demolibrarys
//
//  Created by kivan on 17/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "KIVBaseCVCell.h"

@class KIVHomeCVMiddelCell;
@protocol KIVHomeCVMiddelCellDelegate <NSObject>
- (void)kivHomeCVMiddelCell:(KIVHomeCVMiddelCell *)cell selectedIndexPath:(NSIndexPath *)indexPath;
@end


@interface KIVHomeCVMiddelCell : KIVBaseCVCell

@end
