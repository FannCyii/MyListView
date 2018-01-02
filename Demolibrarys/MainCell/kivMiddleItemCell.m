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


- (void)updataCVCellWithData:(id)aData
{
    if ([aData isKindOfClass:[NSString class]]) {
        self.titleLabel.text = (NSString *)aData;
    }
}
@end
