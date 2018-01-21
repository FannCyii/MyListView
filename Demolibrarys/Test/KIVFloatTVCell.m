//
//  KIVFloatTVCell.m
//  Demolibrarys
//
//  Created by Fann on 21/01/2018.
//  Copyright © 2018 kivan. All rights reserved.
//

#import "KIVFloatTVCell.h"

@interface KIVFloatTVCell() <KIVBaseCellInterface>
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation KIVFloatTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updataCellWithItemData:(id)itemData
{
    self.titleLabel.textColor = [UIColor blackGray];
    self.textLabel.text = itemData;
}

@end
