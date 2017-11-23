//
//  KIVDemo01Cell.m
//  Demolibrarys
//
//  Created by kivan on 23/11/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "KIVDemo01Cell.h"

@interface KIVDemo01Cell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *cellButton;

@end

@implementation KIVDemo01Cell

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
    self.nameLabel.text = aData;
}

- (IBAction)actionAction:(UIButton *)sender
{
    if([self.delegate respondsToSelector:@selector(kivDemo01Cell:didSelectedButton:)]){
        [self.delegate kivDemo01Cell:self didSelectedButton:sender];
    }
}


@end
