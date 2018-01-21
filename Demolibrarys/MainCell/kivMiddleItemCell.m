//
//  kivMiddleItemCell.m
//  Demolibrarys
//
//  Created by kivan on 25/12/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "kivMiddleItemCell.h"

@interface kivMiddleItemCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation kivMiddleItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)updateCellWithItem:(KIVCVCellItem *)item
{
    if ([item.itemData isKindOfClass:[NSString class]]) {
        self.titleLabel.text = (NSString *)item.itemData;
    }
}
@end
