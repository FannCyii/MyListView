//
//  UserInfoTVCell.m
//  Demolibrarys
//
//  Created by Fann on 11/01/2018.
//  Copyright © 2018 kivan. All rights reserved.
//

#import "UserInfoTVCell.h"

@interface UserInfoTVCell()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation UserInfoTVCell

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
    self.textLabel.text = (NSString *)aData;
}

@end
