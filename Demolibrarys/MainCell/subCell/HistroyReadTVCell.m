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
@property (weak, nonatomic) IBOutlet UIImageView *liImageView;
@property (weak, nonatomic) IBOutlet UILabel *aticleNameLabel;

@end

@implementation HistroyReadTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.liImageView.layer.cornerRadius = 6;
    self.liImageView.clipsToBounds = YES;
    self.liImageView.backgroundColor = [UIColor kGreen];
    
    self.aticleNameLabel.textColor = [UIColor blackGray];
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
