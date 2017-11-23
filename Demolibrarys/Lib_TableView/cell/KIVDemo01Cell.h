//
//  KIVDemo01Cell.h
//  Demolibrarys
//
//  Created by kivan on 23/11/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "KIVDSBaseTVCell.h"
@class KIVDemo01Cell;
@protocol KIVDemo01CellDelegate <NSObject>
- (void)kivDemo01Cell:(KIVDemo01Cell *)cell didSelectedButton:(UIButton *)button;
@end

@interface KIVDemo01Cell : KIVDSBaseTVCell

@end
