//
//  KIVHomeCVHeaderCell.h
//  Demolibrarys
//
//  Created by kivan on 17/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "KIVBaseCVCell.h"

@class KIVHomeCVHeaderCell;
@protocol KIVHomeCVHeaderCellDelegate <NSObject>
- (void)kivHomeCVHeaderCell:(KIVHomeCVHeaderCell *)cell didReturnWihtTextField:(UITextField *)textField;
@end

@interface KIVHomeCVHeaderCell : KIVBaseCVCell
//@property (nonatomic, weak) id <KIVHomeCVHeaderCellDelegate> delegate;
@end
