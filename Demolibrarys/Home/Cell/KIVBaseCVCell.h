//
//  KIVBaseCVCell.h
//  Demolibrarys
//
//  Created by kivan on 13/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KIVBaseCVCell;
@protocol KIVCVCellDelegate <NSObject>
- (void)kivaCVCell:(KIVBaseCVCell *)cell SelectedAtIndexOfPath:(NSIndexPath *)indexPath;
@end


@interface KIVBaseCVCell : UICollectionViewCell

@property (nonatomic, weak) id delegate;

- (void)updataCVCellWithData:(id)aData;

@end
