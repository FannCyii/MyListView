//
//  KIVLogMainCell.m
//  Demolibrarys
//
//  Created by kivan on 24/11/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "KIVLogMainCell.h"
#import "KIVTogetherTouchRecogizer.h"

@interface KIVLogMainCell ()<KIVTogetherTouchRecogizerDelegate>
@property (nonatomic, strong) KIVTogetherTouchRecogizer *touchr;
@end


@implementation KIVLogMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.touchr = [KIVTogetherTouchRecogizer new];
    self.touchr.delegate = self;
    [self.touchr registerTouchView:self];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)updateDataWithData:(id)aData
{
    NSLog(@"%@",aData);
}

- (CGFloat)endGoBackWithTogetherTouch:(KIVTogetherTouchRecogizer *)toucher
{
    return 0.2;
}

- (void)endWithTogetherTouch:(KIVTogetherTouchRecogizer *)toucher
{
    
}


@end
