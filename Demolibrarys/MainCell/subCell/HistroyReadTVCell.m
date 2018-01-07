//
//  HistroyReadTVCell.m
//  Demolibrarys
//
//  Created by Fann on 05/01/2018.
//  Copyright © 2018 kivan. All rights reserved.
//

#import "HistroyReadTVCell.h"
#import "ArticleListItem.h"

@interface HistroyReadTVCell()
@property (weak, nonatomic) IBOutlet UILabel *aticleNameLabel;

@end

@implementation HistroyReadTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateDataWithData:(id)aData
{
    ElementInfo *item = (ElementInfo *)aData;
    self.aticleNameLabel.text = item.title;    
}

@end
